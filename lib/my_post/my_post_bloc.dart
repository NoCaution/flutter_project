import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/my_post/my_post_screen_state.dart'as s;
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_repository.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../repositories/user_credential_repository.dart';
import 'my_post_screen_event.dart';

class MyPostBloc extends Bloc<MyPostScreenEvent,s.MyPostScreenState>{
  final UserCredentialRepository userCredential;
  MyPostBloc({required this.userCredential}) : super(s.MyPostScreenState(currentUser: userCredential.user,currentPost: userCredential.post)){

    on<GetCurrentUser>((event,emit)async{
      User? newUser = await UserRepository().getUserById(userCredential.user?.id);
      userCredential.user=newUser;
      emit(state.copyWith(currentUser: newUser));
    });
    on<GetCurrentPost>((event,emit)async{
      Post? newPost = await PostRepository().getPostById(userCredential.post?.userId);
      userCredential.post=newPost;
      emit(state.copyWith(currentPost: newPost));
    });
    on<PostChanged>((event,emit){
      emit(state.copyWith(currentPost: event.changedPost));
    });
  }
}