abstract class VerifyEmailEvent{}

class VerifyEmailCodeChanged extends VerifyEmailEvent{
  final String? code;
  VerifyEmailCodeChanged({this.code});
}

class VerifyEmailSubmitted extends VerifyEmailEvent{}

class VerifyEmailSuccess extends VerifyEmailEvent{}

class VerifyEmailFailed extends VerifyEmailEvent{}

class RestartFormStatus extends VerifyEmailEvent{}

