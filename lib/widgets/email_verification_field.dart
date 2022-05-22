import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/verify_email/verif_email_event.dart'
    as verify_email_event;
import 'package:untitled1/auth/verify_email/verify_email_bloc.dart';
import 'package:untitled1/auth/verify_email/verify_email_state.dart';

class EmailVerificationField extends StatelessWidget {
  final TextEditingController? otpController;
  const EmailVerificationField({Key? key,this.otpController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
        builder: (context, state) {
      return TextFormField(
        cursorColor: Colors.blueAccent,
        style: const TextStyle(
          color: Colors.black54,
        ),
        controller: otpController,
        maxLines: 1,
        obscureText: false,
        onChanged: (value) {
          context
              .read<VerifyEmailBloc>()
              .add(verify_email_event.RestartFormStatus());
          context
              .read<VerifyEmailBloc>()
              .add(verify_email_event.VerifyEmailCodeChanged(code: value));
        },
        validator: (code) {
          if (code!.isEmpty) {
            return "Kod girmelisin!";
          }
          if (code.trim().length != 6) {
            return "Kod 6 haneli olmalı!";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 10, color: Colors.red),
            hintText: "Kod",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            filled: true,
            fillColor: Colors.white.withOpacity(0.75),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8)),
            isDense: true,
            errorMaxLines: 1,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(5))),
      );
    });
  }
}
