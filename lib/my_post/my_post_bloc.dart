import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/my_post/my_post_state.dart' as s;
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_repository.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'my_post_event.dart';
import 'my_post_state.dart';

class MyPostBloc extends Bloc<MyPostEvent,MyPostState>{
  final User? currentUser;
  final Post? currentPost;
  MyPostBloc({this.currentUser,this.currentPost}) : super(MyPostState(currentUser: currentUser,currentPost: currentPost)){

    on<GetCurrentUser>((event,emit)async{
      User? newUser = await UserRepository().getUserById(currentUser!.id);
      emit(state.copyWith(currentUser: newUser));
    });
    on<GetCurrentPost>((event,emit)async{
      Post? newPost = await PostRepository().getPostById(currentUser!.id);
      emit(state.copyWith(currentPost: newPost));
    });
    on<PostChanged>((event,emit){
      emit(state.copyWith(currentPost: event.changedPost));
    });
  }
}