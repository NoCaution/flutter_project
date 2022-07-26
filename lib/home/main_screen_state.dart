import 'package:untitled1/home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';

class HomeScreenState {
  final List<Post>? posts;
  final User? currentUser;
  final Post? currentUserPost;
  final PostStatus? postStatus;


  HomeScreenState({
    this.posts= const[ Post(id: " ",whatToDo: " ",description: " ",age2: 0,age1: 0,location: " ",userId: " ")],
    this.currentUser = const User(id: " ",name: " ",lastName: " ", birth: " ",eMail: " ",password: " ",mobile: " ",imageUrl: " ",autoLogin: false),
    this.currentUserPost = const Post(id: " ",whatToDo: " ",description: " ",age2: 0,age1: 0,location: " ",userId: " "),
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