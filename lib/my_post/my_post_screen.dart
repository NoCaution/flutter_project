import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/home/main_screen_events.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/widgets/post_card_widget.dart';
import '../home/home_navigator_cubit.dart';
import 'my_post_screen_state.dart' as s;
import 'package:untitled1/utils/constants.dart' as constants;
import 'my_post_bloc.dart';
import 'my_post_screen_event.dart' as e;

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
      appBar: _appBar(width: width),
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
                          style: GoogleFonts.gentiumBasic(
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
      child: SingleChildScrollView(
        child: PostCardWidget(
          user: state.currentUser,
          post: state.currentPost,
          dataRepo: context.read<DataRepository>(),
          onHome: false,
        ),
      ),
      padding: const EdgeInsets.only(top: 20),
    );
  }

  Padding _buildMessage({required s.MyPostScreenState state,required double width}){
    return Padding(
      child: Text("   " + _message,
          style: GoogleFonts.gentiumBasic(
              textStyle: TextStyle(
                  color: state.primaryTextColor,
                  fontSize: width * 3.3))),
      padding: const EdgeInsets.all(30),
    );
  }

  final String _message =
      "Henüz hiçbir etkinliğin yok. Yeni bir etkinlik oluşturmak ister misin? Artı işaretine basman yeterli.";

  PreferredSize _appBar({required double width}) {
    return PreferredSize(
        child: BlocBuilder<MyPostBloc, s.MyPostScreenState>(
            builder: ((context, state) {
          return AppBar(
              backgroundColor: constants.appBarColor.withOpacity(0.9),
              title: Row(
                children: [
                  Text(
                    state.currentUser!.userName!,
                    style: GoogleFonts.gentiumBasic(
                        textStyle: TextStyle(
                            fontSize: width * 6, color: Colors.white)),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _archiveButton(context: context),
                      _addPostButton(context: context),
                    ],
                  ))
                ],
              ));
        })),
        preferredSize: AppBar().preferredSize);
  }

  IconButton _archiveButton({required BuildContext context}) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<HomeNavigatorCubit>(context).showArchive();
      },
      icon: const Icon(Icons.archive_rounded),
      splashRadius: 20.0,
    );
  }

  IconButton _addPostButton({required BuildContext context}) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<HomeNavigatorCubit>(context).showAddPost();
      },
      icon: const Icon(Icons.add),
      splashRadius: 20,
    );
  }
}
