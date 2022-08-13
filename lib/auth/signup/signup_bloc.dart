import 'package:email_auth/email_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/auth/signup/signup_event.dart';
import 'package:untitled1/auth/signup/signup_state.dart';
import '../auth_cubit.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository? authRepo;
  final AuthCubit? authCubit;

  SignupBloc({this.authRepo, this.authCubit}) : super(SignupState()) {
    on<SignupNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<SignupLastNameChanged>((event, emit) {
      emit(state.copyWith(lastName: event.lastName));
    });
    on<SignupEmailChanged>((event, emit) {
      emit(state.copyWith(eMail: event.eMail));
    });
    on<SignupPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RestartFormStatus>((event, emit) {
      emit(state.copyWith(formStatus: FormSubmitting()));
    });
    on<SignupSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitted()));
      try {
        await authRepo?.doesUserExist(state.eMail);
        emit(state.copyWith(formStatus: SubmissionFailed(error: "bu email kullanılmaktadır!")));

      } catch (e) {
        if(e.toString()=="Bad state: No element"){
          await authRepo?.sendOtp(eMail: state.eMail);
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          authCubit?.showVerifyEmail(name: state.name,lastName: state.lastName,eMail: state.eMail,password: state.password,);
        }
        else {
          emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
        }
      }
    });
  }
}
