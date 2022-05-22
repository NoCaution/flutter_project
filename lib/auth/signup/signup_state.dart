import 'package:untitled1/auth/form_submission_status.dart';

class SignupState {
  final String? name;
  final String? lastName;
  final String? eMail;
  final String? password;
  final FormSubmissionStatus? formStatus;
  final bool? userExists;

  SignupState({
    this.name = "",
    this.lastName = "",
    this.eMail = "",
    this.password = "",
    this.formStatus = const InitialFormStatus(),
    this.userExists = true,
  });

  SignupState copyWith({
    String? name,
    String? lastName,
    String? eMail,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? userExists,
  }) {
    return SignupState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      eMail: eMail ?? this.eMail,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      userExists: userExists?? this.userExists,
    );
  }

}