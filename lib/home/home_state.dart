import 'package:untitled1/home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';

class HomeState {
  final List<Post>? posts;
  final User? currentUser;
  final Post? currentUserPost;
  final PostStatus? postStatus;
  final Map<String,String>? userInfoForPosts;


  HomeState({
    this.posts= const[ Post(id: " ",whatToDo: " ",description: " ",userId: " ")],
    this.currentUser = const User(id: "",name: "hey",lastName: " ", birth: " ",eMail: " ",password: " ",mobile: " ",imageUrl: " ",autoLogin: false,userName: "", joinedAt:""),
    this.currentUserPost = const Post(id: " ",whatToDo: " ",description: " ",userId: " "),
    this.userInfoForPosts,
    this.postStatus = const InitialPostStatus(),
  }) ;

  HomeState copyWith({
    List<Post>? posts,
    User? currentUser,
    Post? currentUserPost,
    PostStatus? postStatus,
    Map<String,String>? userInfoForPosts,
  }){
    return HomeState(
      posts: posts ?? this.posts,
      currentUser: currentUser ?? this.currentUser,
      currentUserPost: currentUserPost ?? this.currentUserPost,
      postStatus: postStatus ?? this.postStatus,
      userInfoForPosts: userInfoForPosts ?? this.userInfoForPosts,
    );
  }
}