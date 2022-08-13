import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/signup/signup_event.dart';
import 'package:untitled1/auth/signup/signup_state.dart';
import 'package:untitled1/validators/validations.dart';
import '../auth/signup/signup_bloc.dart';

class SignUpPasswordField extends StatelessWidget{
  const SignUpPasswordField({Key? key,}) : super(key: key);

  @override
  Widget build(context) {
    return BlocBuilder<SignupBloc,SignupState>(
        builder: (context, state) {
          return TextFormField(
            cursorColor: Colors.blueAccent,
            style: const TextStyle(
              color: Colors.black54,
            ),
            maxLines: 1,
            obscureText: true,
            onChanged: (value){
              context.read<SignupBloc>().add(RestartFormStatus());
              context.read<SignupBloc>().add(SignupPasswordChanged(password: value));
            },
            validator: Validations().passwordValidator,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.password,
                  color: Colors.cyan,
                ),
                errorStyle: const TextStyle(fontSize: 9),
                hintText: "Şifre",
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
                    borderRadius: BorderRadius.circular(5))),
          );
        });
  }
}