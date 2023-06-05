import 'dart:ui';
import 'package:untitled1/utils/constants.dart' as constants;
import '../home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';

class MyPostState {
  final Post? currentPost;
  final User? currentUser;
  final Color? primaryTextColor;
  final PostStatus? postStatus;

  MyPostState({
    Color? primaryTextColor,
    PostStatus? postStatus,
    required Post? currentPost,
    required User? currentUser,
  })  : postStatus = const InitialPostStatus(),
        currentPost = currentPost,
        currentUser = currentUser,
        primaryTextColor = constants.primaryTextColor.withOpacity(0.75);

  MyPostState copyWith({
    Post? currentPost,
    User? currentUser,
    PostStatus? postStatus,
    Color? primaryTextColor,
  }) {
    return MyPostState(
        currentPost: currentPost ?? this.currentPost,
        currentUser: currentUser ?? this.currentUser,
        postStatus: postStatus ?? this.postStatus,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        );
  }
}