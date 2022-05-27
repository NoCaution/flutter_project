import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/login/auth_repository.dart';
import '../auth_cubit.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepository;
  final AuthCubit? authCubit;

  LoginBloc({this.authRepository, this.authCubit}) : super(LoginState()) {
    {
      on<LoginEmailChanged>((event, emit) {
        emit(state.copyWith(eMail: event.eMail));
      });
      on<LoginPasswordChanged>((event, emit) {
        emit(state.copyWith(password: event.password));
      });
      on<RestartFormStatus>((event, emit) {
        emit(state.copyWith(formStatus: FormSubmitting()));
      });
      on<AutoLoginActivated>((event, emit) async {
        emit(state.copyWith(autoLogin: true));
      });
      on<AutoLoginDeactivated>((event, emit) {
        emit(state.copyWith(autoLogin: false));
      });
      on<LoginSubmitted>((event, emit) async {
        emit(state.copyWith(formStatus: FormSubmitted()));
        try {
          String eMail = state.eMail!.trim();
          String password = state.password!.trim();
          var user = await authRepository?.login(
            eMail: eMail,
            password: password,
          );
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          authCubit?.loginShowMainScreen(user);
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
        }
      });
    }
  }
}