import 'dart:ui';
import 'package:untitled1/utils/constants.dart' as constants;
import '../home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';

class ArchiveState {
  final List<Post>? archivedPosts;
  final Color? primaryTextColor;
  final PostStatus? postsStatus;
  final User? currentUser;

  ArchiveState({
    this.archivedPosts ,
    this.primaryTextColor = constants.primaryTextColor,
    this.postsStatus = const InitialPostStatus(),
    this.currentUser,
  });

  ArchiveState copyWith({
    List<Post>? archivedPosts,
    Color? primaryTextColor,
    PostStatus? postsStatus,
    User? currentUser,
  }) {
    return ArchiveState(
      archivedPosts: archivedPosts ?? this.archivedPosts,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      postsStatus: postsStatus ?? this.postsStatus,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
