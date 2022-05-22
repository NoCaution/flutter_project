import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/services/post_services.dart';

import '../models/post.dart';

abstract class PostsEvent{}

class LoadPostsEvent extends PostsEvent{}
class PullToRefreshEvent extends PostsEvent{}

abstract class PostsState{}

class LoadingPostsState extends PostsState{}
class LoadedPostsState extends PostsState{
  List<Post>? posts;
  LoadedPostsState({this.posts});
}
class FailedToLoadPostsState extends PostsState{
  Error? error;
  FailedToLoadPostsState({this.error});
}

class PostBloc extends Bloc<PostsEvent,PostsState>{
  final _postService = PostService();
  PostBloc():super(LoadingPostsState());

  @override
  Stream<PostsState> onEvent(PostsEvent event) async*{
    super.onEvent(event);
    if(event is LoadPostsEvent || event is PullToRefreshEvent){
      yield LoadingPostsState();
      try{
        final posts = await _postService.getPosts();
        yield LoadedPostsState(posts: posts);
      }catch(e){
        yield FailedToLoadPostsState(error: e as Error);
      }
    }
  }
}