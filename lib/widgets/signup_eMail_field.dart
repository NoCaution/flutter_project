import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/signup/signup_event.dart';
import 'package:untitled1/auth/signup/signup_state.dart';
import '../auth/signup/signup_bloc.dart';

class SignUpEmailField extends StatelessWidget {
  final TextEditingController? textEditingController;

  const SignUpEmailField({Key? key, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc,SignupState>(builder: (context, state) {
      return TextFormField(
          cursorColor: Colors.blueAccent,
          style: const TextStyle(
            color: Colors.black54,
          ),
          controller: textEditingController,
          maxLines: 1,
          onChanged: (value){
            context.read<SignupBloc>().add(SignupEmailChanged(eMail: value));
          },
          validator: (eMail) {
            if (eMail!.isEmpty) {
              return "bir Email girmelisin!";
            }
            if (isValidEmail(eMail) == false) {
              return "geçerli bir Email girmelisin!";
            }
            return null;
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.cyan,
              ),
              errorStyle: const TextStyle(fontSize: 9),
              hintText: "Email",
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              filled: true,
              fillColor: Colors.white.withOpacity(0.80),
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
                  borderRadius: BorderRadius.circular(5))));
    });
  }

  bool isValidEmail(String eMail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(eMail)) ? false : true;
  }
}