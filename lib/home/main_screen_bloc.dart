import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/post_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import '../home/main_screen_state.dart' ;
import 'package:untitled1/home/main_screen_events.dart';
import '../repositories/user_repository.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, HomeScreenState> {
  var currentUser = FirebaseAuth.instance.currentUser;
  static final MainScreenBloc _signleton = MainScreenBloc._internal();

  factory MainScreenBloc(){
    return _signleton;
  }


  MainScreenBloc._internal(): super(HomeScreenState()){
    on<PullToRefresh>((event, emit) async {
      try {
        var posts = await PostRepository().getPosts();
        emit(state.copyWith(posts: posts,postStatus: GetPostsSuccessful()));
      } catch (e) {
        emit(state.copyWith(
            postStatus: GetPostsFailed(exception: e as Exception)));
      }
    });

    on<Refresh>((event, emit) async {
      try {
        emit(state.copyWith(postStatus: GettingPosts()));
        var posts = await PostRepository().getPosts();
        emit(state.copyWith(posts: posts,postStatus: GetPostsSuccessful()));

      } catch (e) {
        emit(state.copyWith(
            postStatus: GetPostsFailed(exception: e as Exception)));
      }
    });

    on<GetCurrentUser>((event, emit) async {
      var user = await UserRepository().getUserById(currentUser!.uid);
      emit(state.copyWith(currentUser: user!));

    });

    on<GetCurrentUserPost>((event, emit) async {
      var currentUserPost =await PostRepository().getPostById(currentUser!.uid);
      emit(state.copyWith(currentUserPost: currentUserPost!));
    });
  }
}
