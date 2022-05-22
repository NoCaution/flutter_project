import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/signup/signup_bloc.dart';
import 'package:untitled1/auth/signup/signup_event.dart';

import '../auth/signup/signup_state.dart';


class NameField extends StatelessWidget {
  final TextEditingController? textEditingController;

  const NameField({Key? key, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc,SignupState>(
      builder: (context, state) {
        return TextFormField(
            cursorColor: Colors.blueAccent,
            style: const TextStyle(
              color: Colors.black54,
            ),
            controller: textEditingController,
            maxLines: 1,
            validator: (name) {
              if (name!.isEmpty) {
                return "isim boşluk olamaz!";
              }
              return null;
            },
            onChanged: (value){
              context.read<SignupBloc>().add(SignupNameChanged(name: value));
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.add,
                  color: Colors.cyan,
                ),
                errorStyle: const TextStyle(fontSize: 9),
                hintText: "İsim",
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
}