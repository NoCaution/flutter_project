import 'package:untitled1/auth/form_submission_status.dart';
import '../../models/user.dart';

class LoginState{
  final String? eMail;
  final String? password;
  final FormSubmissionStatus formStatus;
  final bool? autoLogin;

  LoginState({
    this.eMail="",
    this.password="",
    this.formStatus = const InitialFormStatus(),
    this.autoLogin=false,
  });

  LoginState copyWith({
  String? eMail,
  String? password,
  FormSubmissionStatus? formStatus,
  bool? autoLogin,

  }){
    return LoginState(
      eMail: eMail?? this.eMail,
      password: password?? this.password,
      formStatus: formStatus?? this.formStatus,
      autoLogin: autoLogin?? this.autoLogin,
    );
  }
}

