import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/archive/archive_screen.dart';
import 'package:untitled1/archive/archive_screen_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen.dart';
import 'package:untitled1/custom_page_route.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/widgets/post_card_widget.dart';
import '../home/home_navigator_cubit.dart';
import '../models/user.dart';
import 'my_post_screen_state.dart' as s;
import 'package:untitled1/utils/constants.dart' as constants;
import 'my_post_bloc.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({Key? key, required this.postBloc}) : super(key: key);
  final MyPostBloc postBloc;

  @override
  State<StatefulWidget> createState() {
    return MyPostScreenState();
  }
}

class MyPostScreenState extends State<MyPostScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      appBar: _appBar(width: width, newContext: context),
      body: BlocProvider(
        create: (BuildContext context) => MyPostBloc(
            userCredential: context.read<UserCredentialRepository>()),
        child: BlocBuilder<MyPostBloc, s.MyPostScreenState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 25, left: 20),
                        child: Text(
                          "Etkinliğim",
                          style: GoogleFonts.gentiumBookBasic(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: state.primaryTextColor,
                            fontSize: width * 6,
                          )),
                        ))
                  ],
                ),
                state.currentPost?.whatToDo == null
                    ? _buildMessage(state: state,width: width)
                    : _buildPostCard(state: state, context: context)
              ],
            );
          },
        ),
      ),
    );
  }

  //COMPONENTS

  Padding _buildPostCard({required s.MyPostScreenState state,required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: PostCardWidget(
          user: state.currentUser!,
          post: state.currentPost!,
          dataRepo: context.read<DataRepository>(),
          onHome: false,
        ),
      ),
    );
  }

  Padding _buildMessage({required s.MyPostScreenState state,required double width}){
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Text("   $_message",
          style: GoogleFonts.gentiumBookBasic(
              textStyle: TextStyle(
                  color: state.primaryTextColor,
                  fontSize: width * 3.3))),
    );
  }

  final String _message =
      "Henüz hiçbir etkinliğin yok. Yeni bir etkinlik oluşturmak ister misin? Artı işaretine basman yeterli.";

  PreferredSize _appBar({required double width,required BuildContext newContext}) {
    return PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: BlocBuilder<MyPostBloc, s.MyPostScreenState>(
            builder: ((context, state) {
          return AppBar(
              backgroundColor: constants.appBarColor.withOpacity(0.9),
              title: Row(
                children: [
                  Text(
                    state.currentUser!.userName!,
                    style: GoogleFonts.gentiumBookBasic(
                        textStyle: TextStyle(
                            fontSize: width * 6, color: Colors.white)),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _addPostButton(context: context,currentUser: state.currentUser!),
                      _archiveButton(context: newContext),
                    ],
                  ))
                ],
              ));
        })));
  }
  IconButton _addPostButton({required BuildContext context,required User currentUser}) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(CustomPageRoute(child: NewPostScreen(currentUser: currentUser,)));
      },
      icon: const Icon(Icons.add),
      splashRadius: 20,
    );
  }
  IconButton _archiveButton({required BuildContext context}) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ArchiveScreen(archiveBloc: context.read<ArchiveScreenBloc>(), userCredential: context.read<UserCredentialRepository>(), dataRepo: context.read<DataRepository>(),)));
      },
      icon: const Icon(Icons.archive_rounded),
      splashRadius: 20.0,
    );
  }
}
