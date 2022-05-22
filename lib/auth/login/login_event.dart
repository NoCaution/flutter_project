abstract class LoginEvent{}

class LoginEmailChanged extends LoginEvent{
  final String? eMail;
  LoginEmailChanged({this.eMail});
}

class LoginPasswordChanged extends LoginEvent{
  final String? password;
  LoginPasswordChanged({this.password});
}

class LoginSubmitted extends LoginEvent{
  LoginSubmitted();
}

class RestartFormStatus extends LoginEvent{}

class AutoLoginActivated extends LoginEvent{}

class AutoLoginDeactivated extends LoginEvent{}