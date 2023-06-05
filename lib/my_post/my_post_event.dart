import '../models/post.dart';

abstract class MyPostEvent{}

class GetCurrentUser extends MyPostEvent{}

class GetCurrentPost extends MyPostEvent{}

class PostChanged extends MyPostEvent {
  final Post? changedPost;
  PostChanged({this.changedPost});
}