abstract class FormSubmissionStatus{
  const FormSubmissionStatus();
}


class InitialFormStatus extends FormSubmissionStatus{
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus{}

class FormSubmitted extends FormSubmissionStatus{}

class SubmissionSuccess extends FormSubmissionStatus{}

class SubmissionFailed extends FormSubmissionStatus{
  final Object? exception;
  final String? error;
  SubmissionFailed({this.exception,this.error});
}