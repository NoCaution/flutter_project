import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/signup/signup_bloc.dart';
import 'package:untitled1/auth/signup/signup_event.dart';
import 'package:untitled1/auth/signup/signup_state.dart';

class LastNameField extends StatelessWidget {
  const LastNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<SignupBloc,SignupState>(
        builder: (context,state) {
          return TextFormField(
              cursorColor: Colors.blueAccent,
              style: const TextStyle(
                color: Colors.black54,
              ),
              maxLines: 1,
              onChanged: (value) {
                context.read<SignupBloc>().add(RestartFormStatus());
                context.read<SignupBloc>().add(SignupLastNameChanged(lastName: value));
              },
              validator: (lastName) {
                if (lastName!.isEmpty) {
                  return "soy isim boşluk olamaz!";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add,color: Colors.cyan,),
                  errorStyle: const TextStyle(fontSize: 9),
                  hintText: "E-mail",
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
        }
      );
  }
}
