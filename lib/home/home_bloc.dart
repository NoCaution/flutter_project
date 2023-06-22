import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/post_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import '../home/home_state.dart';
import 'package:untitled1/home/home_events.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final User? currentUser;
  final Post? currentUserPost;
  HomeBloc({this.currentUser,this.currentUserPost}): super(HomeState(currentUser: currentUser,currentUserPost: currentUserPost)){
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
        var userInfoForPost = await UserRepository().getUserInfoForPost();
        var posts = await PostRepository().getPosts();
        emit(state.copyWith(posts: posts,postStatus: GetPostsSuccessful(),userInfoForPosts: userInfoForPost));
      } catch (e) {
        emit(state.copyWith(
            postStatus: GetPostsFailed(exception: e as Exception)));
      }
    });

    on<GetCurrentUser>((event, emit) async {
      var user = await UserRepository().getUserById(currentUser!.id);
      emit(state.copyWith(currentUser: user!));
    });

    on<GetCurrentUserPost>((event, emit) async {
      var userPost =await PostRepository().getPostById(currentUser!.id);
      emit(state.copyWith(currentUserPost: userPost));

    });
  }
}
