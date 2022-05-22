abstract class SignupEvent{}

class SignupNameChanged extends SignupEvent{
  String? name;
  SignupNameChanged({this.name});
}

class SignupLastNameChanged extends SignupEvent{
  String? lastName;
  SignupLastNameChanged({this.lastName});
}

class SignupEmailChanged extends SignupEvent{
  String? eMail;
  SignupEmailChanged({this.eMail});
}

class SignupPasswordChanged extends SignupEvent{
  String? password;
  SignupPasswordChanged({this.password});
}

class SignupSubmitted extends SignupEvent{
  SignupSubmitted();
}
class RestartFormStatus extends SignupEvent{}

class UserExists extends SignupEvent{}

class UserNotExist extends SignupEvent{}