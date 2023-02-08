import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_state.dart';
import 'new_post_screen_bloc.dart';
import 'new_post_screen_events.dart';

class NewPostWhatToDoFormField extends StatelessWidget{
  const NewPostWhatToDoFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostScreenBloc,NewPostScreenState>(builder: (context,state){
      return TextFormField(
          cursorColor: Colors.blueAccent,
          style: const TextStyle(
            color: Colors.black54,
          ),
          onChanged: (value){
            context.read<NewPostScreenBloc>().add(NewPostWhatToDoChanged(whatToDo: value));
          },
          maxLines: null,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 9),
              fillColor: Colors.white,
              hintText: "ne yapacaksın?",
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