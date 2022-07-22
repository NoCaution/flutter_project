import 'package:untitled1/home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';

class HomeScreenState {
  final List<Post>? posts;
  final User? currentUser;
  final Post? currentUserPost;
  final PostStatus? postStatus;

  HomeScreenState({
    this.posts,
    this.currentUser ,
    this.currentUserPost,
    this.postStatus = const InitialPostStatus(),
  }) ;

  HomeScreenState copyWith({
    List<Post>? posts,
    User? currentUser,
    Post? currentUserPost,
    PostStatus? postStatus,
  }){
    return HomeScreenState(
      posts: posts ?? this.posts,
      currentUser: currentUser ?? this.currentUser,
      currentUserPost: currentUserPost ?? this.currentUserPost,
      postStatus: postStatus ?? this.postStatus,
    );
  }


}