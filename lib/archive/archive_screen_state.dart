import 'dart:ui';
import 'package:untitled1/utils/constants.dart' as constants;
import '../home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';

class ArchiveScreenState {
  final List<Post>? archivedPosts;
  final Color? primaryTextColor;
  final PostStatus? postsStatus;
  final User? currentUser;

  ArchiveScreenState({
    this.archivedPosts,
    this.primaryTextColor = constants.primaryTextColor,
    this.postsStatus = const InitialPostStatus(),
    this.currentUser,
  });

  ArchiveScreenState copyWith({
    List<Post>? archivedPosts,
    Color? primaryTextColor,
    PostStatus? postsStatus,
    User? currentUser,
  }) {
    return ArchiveScreenState(
      archivedPosts: archivedPosts ?? this.archivedPosts,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      postsStatus: postsStatus ?? this.postsStatus,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
