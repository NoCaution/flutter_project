import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/repositories/user_repository.dart';
import 'package:untitled1/session_state.dart';
import 'auth/auth_repository.dart';
import 'models/post.dart';
import 'models/user.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository? authRepo;
  final UserCredentialRepository userCredentialRepo;
  User? get getCurrentUser =>  (state as Authenticated).user;

  SessionCubit( {
    this.authRepo,
    required this.userCredentialRepo,
  }) : super(UnknownMainScreenState()) {
    attemptAutoLogin();
    //if user is signed in in firebase, it will autologin
  }

  void attemptAutoLogin() async {
    try{
    final userId = authRepo?.attemptAutoLogin();
    if (userId == null) {
      throw Exception("user not logged in");
    } else {
      User user = await UserRepository().getUserById(userId)!;
      Post post = await PostRepository().getPostById(userId)!;
      userCredentialRepo.user=user;
      userCredentialRepo.post = post;
      if(user.autoLogin == true){
        emit(Authenticated(user: user,post: post));
      }else{
        emit(UnAuthenticated());
      }
    }}on Exception{
      emit(UnAuthenticated());
    }
  }

void showAuth() {
  emit(UnAuthenticated());
}

void showMainScreen() async{
  String? userId = authRepo?.attemptAutoLogin();
  if(userId ==null){
    emit(UnAuthenticated());
  }else{
    User? user = await UserRepository().getUserById(userId);
    Post? post = await PostRepository().getPostById(userId);
    userCredentialRepo.user =user ;
    userCredentialRepo.post =post;
    emit(Authenticated(user: user,post: post));
  }
}

void signOut() {
  authRepo?.signOut();
  emit(UnAuthenticated());
}}
