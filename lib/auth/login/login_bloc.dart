import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import '../auth_cubit.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepository;
  final AuthCubit? authCubit;
  final User? user;

  LoginBloc({this.authRepository, this.authCubit, this.user})
      : super(LoginState()) {
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
        User user = await UserRepository().getUserByEmail(state.eMail)!;
        User newUser = user.copyWith(
            id: user.id,
            name: user.name,
            lastName: user.lastName,
            birth: user.birth,
            eMail: user.eMail,
            password: user.password,
            mobile: user.mobile,
            imageUrl: user.imageUrl,
            autoLogin: true);
        await UserRepository().updateUser(newUser);
      });
      on<AutoLoginDeactivated>((event, emit) async {
        emit(state.copyWith(autoLogin: false));
        User user = await UserRepository().getUserByEmail(state.eMail)!;
        User newUser = user.copyWith(
            id: user.id,
            name: user.name,
            lastName: user.lastName,
            birth: user.birth,
            eMail: user.eMail,
            password: user.password,
            mobile: user.mobile,
            imageUrl: user.imageUrl,
            autoLogin: false);
        await UserRepository().updateUser(newUser);
      });
      on<LoginSubmitted>((event, emit) async {
        emit(state.copyWith(formStatus: FormSubmitted()));
        try {
          await authRepository?.login(
            eMail: state.eMail!.trim(),
            password: state.password!.trim(),
          );
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          authCubit?.showMainScreen();
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
        }
      });
    }
  }
}
