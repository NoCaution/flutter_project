abstract class PostSubmissionStatus {
  const PostSubmissionStatus();
}
class InitialPostStatus extends PostSubmissionStatus{
  const InitialPostStatus();
}
class PostSubmissionSuccess extends PostSubmissionStatus{}

class PostSubmissionFailed extends PostSubmissionStatus{
  final Exception? exception;
  PostSubmissionFailed({this.exception});
}

