import 'package:untitled1/home/main_screen.dart';
import 'package:untitled1/home/post_status.dart';

import '../models/post.dart';
import '../models/user.dart';

class MainScreenState {
  final List<Post>? posts;
  final List<User>? currentUser;
  final List<Post>? currentUserPost;
  final PostStatus? postStatus;

  MainScreenState({
    this.posts = const [],
    this.currentUser = const [] ,
    this.currentUserPost = const [],
    this.postStatus = const InitialPostStatus(),
  });

  MainScreenState copyWith({
    List<Post>? posts,
    List<User>? currentUser,
    List<Post>? currentUserPost,
    PostStatus? postStatus,
  }){
    return MainScreenState(
      posts: posts ?? this.posts,
      currentUser: currentUser ?? this.currentUser,
      currentUserPost: currentUserPost ?? this.currentUserPost,
      postStatus: postStatus ?? this.postStatus,
    );
  }


}