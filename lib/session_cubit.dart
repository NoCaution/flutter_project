import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/repositories/user_repository.dart';
import 'package:untitled1/session_state.dart';
import 'auth/auth_repository.dart';
import 'models/user.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository? authRepo;

  User? get getCurrentUser => (state as Authenticated).user;


  SessionCubit({
    this.authRepo,
  }) : super(UnknownMainScreenState()) {
    attemptAutoLogin();
    //if user is signed in in firebase, it will autologin
  }

  void attemptAutoLogin() async {
    String? userId = authRepo?.attemptAutoLogin();
    if (userId == null) {
      emit(UnAuthenticated());
    } else {
      User user = await UserRepository().getUserById(userId)!;
      user.autoLogin == true
          ? emit(Authenticated(user: user))
          : emit(UnAuthenticated());
    }
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
}}
