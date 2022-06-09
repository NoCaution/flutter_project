import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/session_state.dart';
import 'auth/auth_repository.dart';
import 'auth/login/login_screen_widget.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository? authRepo;

  SessionCubit({
    this.authRepo,
  }) : super(UnAuthenticated()){
    authRepo?.attemptAutoLogin() == null ? null : attemptAutoLogin();

    //if user is signed in in firebase and activated autologin in login screen it will autologin
  }

  void attemptAutoLogin() {
    emit(Authenticated());
  }

  void showAuth() {
    emit(UnAuthenticated());
  }

  void showMainScreen() {
    emit(Authenticated());
  }

  void signOut() {
    authRepo?.signOut();
    emit(UnAuthenticated());
  }
}
