import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_events.dart';
import 'package:untitled1/create_new_post/new_post_screen_state.dart';

import '../add_post/add_post_screen_event.dart';

class NewPostDescriptionFormField extends StatelessWidget{
  const NewPostDescriptionFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostScreenBloc,NewPostScreenState>(builder: (context,state){
      return TextFormField(
          cursorColor: Colors.blueAccent,
          style: const TextStyle(
            color: Colors.black54,
          ),
          onChanged: (value){
            context.read<NewPostScreenBloc>().add(NewPostDescriptionChanged(description: value));
          },
          validator: (description) {
            if (description!.isEmpty) {
              return "açıklama boşluk olamaz!";
            }
            if(description.length<5){
              return "açıklama minimum 5 karakter olmalı!";
            }
            return null;
          },
          maxLines: null,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 9),
              fillColor: Colors.white,
              hintText: "açıklama yaz..",
              contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              filled: true,
              isDense: true,
              errorMaxLines: 1,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
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