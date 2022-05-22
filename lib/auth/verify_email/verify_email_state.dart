import 'package:untitled1/auth/form_submission_status.dart';

class VerifyEmailState {
  final String? code;
  final FormSubmissionStatus? formStatus;
  final String? eMail;

  VerifyEmailState({
    this.code = "",
    this.formStatus = const InitialFormStatus(),
    this.eMail="",
  });

  VerifyEmailState copyWith({
    String? code,
    FormSubmissionStatus? formStatus,
    String? eMail,
  }) {
    return VerifyEmailState(
      code: code ?? this.code,
      formStatus: formStatus ?? this.formStatus,
      eMail: eMail?? this.eMail,
    );
  }
}
