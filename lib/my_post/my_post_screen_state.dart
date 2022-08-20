import 'dart:ui';
import 'package:untitled1/utils/constants.dart' as constants;
import '../home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';

class MyPostScreenState {
  final Post? currentPost;
  final User? currentUser;
  final Color? primaryTextColor;
  final PostStatus? postStatus;

  MyPostScreenState({
    Color? primaryTextColor,
    PostStatus? postStatus,
    required Post? currentPost,
    required User? currentUser,
  })  : currentPost = currentPost,
        currentUser = currentUser,
        postStatus = const InitialPostStatus(),
        primaryTextColor = constants.primaryTextColor.withOpacity(0.75);

  MyPostScreenState copyWith({
    Post? currentPost,
    User? currentUser,
    PostStatus? postStatus,
    Color? primaryTextColor,
  }) {
    return MyPostScreenState(
        currentPost: currentPost ?? this.currentPost,
        currentUser: currentUser ?? this.currentUser,
        postStatus: postStatus ?? this.postStatus,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        );
  }
}