import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/session_cubit.dart';
import '../models/user.dart';
import 'auth_credentials.dart';

enum AuthState { login, signUp, verifyEmail,passwordForgot, }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({this.sessionCubit,}) : super(AuthState.login);
  AuthCredentials? credentials;
  final SessionCubit? sessionCubit;


  void showLogin() {
    emit(AuthState.login);
  }

  void showSignUp() {
    emit(AuthState.signUp);
  }

  void showVerifyEmail({
    String? name,
    String? lastName,
    String? eMail,
    String? password,
  }) {
    credentials = AuthCredentials(
      eMail: eMail!,
      lastName: lastName!,
      name: name!,
      password: password!,
    );
    emit(AuthState.verifyEmail);
  }

  void showPasswordForgot(){
    emit(AuthState.passwordForgot);
  }

  void showMainScreen(){
    sessionCubit?.showMainScreen();
  }

}
