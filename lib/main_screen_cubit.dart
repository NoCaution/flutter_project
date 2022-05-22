import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/main_screen_state.dart';
import 'auth/login/auth_repository.dart';
import 'models/user.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  final AuthRepository? authRepo;

  MainScreenCubit({
    this.authRepo,
  }) : super(UnAuthenticated()) {
    authRepo?.attemptAutoLogin() == "" ? null : attemptAutoLogin(); //if user is signed in in firebase it will autologin
  }

  void attemptAutoLogin() {
    emit(Authenticated());
  }

  void showAuth() {
    emit(UnAuthenticated());
  }

  void showMainScreen(User? user) async {
    emit(Authenticated(user: user));
  }

  void signOut() {
    authRepo?.signOut();
    emit(UnAuthenticated());
  }
}
