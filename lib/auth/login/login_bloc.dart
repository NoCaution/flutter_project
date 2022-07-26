import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/services/user_methods.dart';
import 'package:untitled1/services/user_services.dart';
import '../../models/user.dart';
import '../auth_cubit.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepository;
  final AuthCubit? authCubit;
  final User? user;

  LoginBloc({this.authRepository, this.authCubit,this.user}) : super(LoginState()) {
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
        User user = await UserService().getUserByEmail(state.eMail)!;
        User newUser = user.copyWith(id: user.id,name: user.name,lastName: user.lastName,birth: user.birth,eMail: user.eMail,password: user.password,mobile: user.mobile,imageUrl: user.imageUrl,autoLogin: true);
        await UserService().updateUser(newUser);
      });
      on<AutoLoginDeactivated>((event, emit)async {
        emit(state.copyWith(autoLogin: false));
        User user = await UserService().getUserByEmail(state.eMail)!;
        User newUser = user.copyWith(id: user.id,name: user.name,lastName: user.lastName,birth: user.birth,eMail: user.eMail,password: user.password,mobile: user.mobile,imageUrl: user.imageUrl,autoLogin: false);
        await UserService().updateUser(newUser);
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
          authCubit?.showMainScreen();
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
        }
      });
    }
  }
}
