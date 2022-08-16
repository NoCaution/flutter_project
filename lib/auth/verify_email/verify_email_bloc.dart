import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/auth/verify_email/verif_email_event.dart';
import 'package:untitled1/auth/verify_email/verify_email_state.dart';
import '../auth_cubit.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final AuthRepository? authRepo;
  final AuthCubit? authCubit;

  VerifyEmailBloc({this.authRepo,this.authCubit}) : super(VerifyEmailState()) {
    on<VerifyEmailCodeChanged>((event, emit) {
      emit(state.copyWith(code: event.code));
    });
    on<RestartFormStatus>((event,emit){
      emit(state.copyWith(formStatus: FormSubmitting()));
    });
    on<VerifyEmailSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        var authCredentials = authCubit!.credentials!;
        var response = authRepo?.verify(eMail: authCredentials.eMail,code: state.code);
        if(response ==true ){
          await authRepo?.signUp(name: authCredentials.name, lastName: authCredentials.lastName, eMail: authCredentials.eMail, password: authCredentials.password);
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          authCubit?.showMainScreen();
        }
        else if(response==false){
          emit(state.copyWith(formStatus: SubmissionFailed(error: "girilen kod yanlış!")));
        }

      } catch (e) {
        emit(state.copyWith(
            formStatus: SubmissionFailed(exception: e as Exception)));
      }
    });
  }
}
