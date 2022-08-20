import '../models/post.dart';

abstract class MyPostScreenEvent{}

class GetCurrentUser extends MyPostScreenEvent{}

class GetCurrentPost extends MyPostScreenEvent{}

class PostChanged extends MyPostScreenEvent {
  final Post? changedPost;
  PostChanged({this.changedPost});
}