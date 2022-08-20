import '../models/post.dart';

abstract class PostStatus {
  const PostStatus();
}
class InitialPostStatus extends PostStatus{
  const InitialPostStatus();
}

class GetPostsSubmitted extends PostStatus{}

class GettingPosts extends PostStatus {}

class GetPostsFailed extends PostStatus {
  final Exception? exception;
  GetPostsFailed({this.exception});
}

class GetPostsSuccessful extends PostStatus {}

