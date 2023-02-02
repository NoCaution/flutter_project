abstract class NewPostStatus{
  const NewPostStatus();
}

class InitNewPostStatus extends NewPostStatus{
  const InitNewPostStatus();
}

class NewPostSubmitted extends NewPostStatus{}

class NewPostSubmissionSuccess extends NewPostStatus{}

class NewPostSubmissionFailed extends NewPostStatus{
  final Exception? exception;
  NewPostSubmissionFailed({this.exception});
}

class NewPostUnknownState extends NewPostStatus{}