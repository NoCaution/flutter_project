import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/session_cubit.dart';
import '../models/user.dart';
import 'add_post_bloc.dart';
import 'add_post_state.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPostScreenState();
  }
}

class AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
      create: (context) =>
          AddPostBloc(currentUser: sessionCubit.getCurrentUser!),
      child: BlocBuilder<AddPostBloc, AddPostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(),
            body: Container(),
          );
        },
      ),
    );
  }
}

PreferredSize _appBar() {
  return PreferredSize(
    child: AppBar(),
    preferredSize: AppBar().preferredSize,
  );
}
