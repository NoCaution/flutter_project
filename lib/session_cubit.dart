import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/services/user_services.dart';
import 'package:untitled1/session_state.dart';
import 'auth/auth_repository.dart';
import 'models/user.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository? authRepo;

  User? get getCurrentUser => (state as Authenticated).user;

  User? get getSelectedUser => (state as Authenticated).selectedUser;

  bool get isCurrentUserSelected =>
      getSelectedUser == null || getCurrentUser?.id == getSelectedUser?.id;

  SessionCubit({
    this.authRepo,
  }) : super(UnAuthenticated()) {
    attemptAutoLogin();
    //if user is signed in in firebase, it will autologin
  }

  void attemptAutoLogin() async {
    String? userId = authRepo?.attemptAutoLogin();
    if (userId == null) {
      emit(UnAuthenticated());
    } else {
      User user = await UserService().getUserById(userId)!;
      if (user.autoLogin == true) {
        emit(Authenticated(user: user));
      } else {
        emit(UnAuthenticated());
      }
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
  }
}
