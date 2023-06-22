import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/archive/archive_screen.dart';
import 'package:untitled1/archive/archive_bloc.dart';
import 'package:untitled1/archive/archive_state.dart';
import 'package:untitled1/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:untitled1/create_new_post/new_post_screen.dart';
import 'package:untitled1/custom_page_route.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/session_cubit.dart';
import 'package:untitled1/utils/custom_icons.dart';
import 'package:untitled1/widgets/post_card_widget.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'my_post_state.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import 'my_post_bloc.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen(
      {Key? key, required this.bottomNavBarCubit, required this.sessionCubit})
      : super(key: key);
  final BottomNavigationBarCubit bottomNavBarCubit;
  final SessionCubit sessionCubit;

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
    SessionCubit sessionCubit = widget.sessionCubit;
    return BlocProvider(
      create: (BuildContext context) => MyPostBloc(
        currentUser: sessionCubit.getCurrentUser!,
        currentPost: sessionCubit.getCurrentPost!,
      ),
      child: BlocBuilder<MyPostBloc, MyPostState>(
        builder: (context, state) {
          var userInfo ="${state.currentUser!.name} ${state.currentUser!.lastName} ${state.currentUser!.imageUrl}";
          return Scaffold(
            backgroundColor: constants.backGroundColor,
            appBar: _appBar(width: width, context: context, state: state),
            body: Column(
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
                    ? _buildMessage(state: state, width: width)
                    : _buildPostCard(currentPost: state.currentPost!,userInfo: userInfo)
              ],
            ),
          );
        },
      ),
    );
  }

  //COMPONENTS

  Widget _buildPostCard(
      {required Post currentPost,required String userInfo}) {
    return SingleChildScrollView(
        child: PostCardWidget(
          userInfoForPost: userInfo,
          post: currentPost,
          dataRepo: context.read<DataRepository>(),
          onHome: false,
        ),
      );
  }

  Padding _buildMessage({required MyPostState state, required double width}) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Text("   $_message",
          style: GoogleFonts.gentiumBookBasic(
              textStyle: TextStyle(
                  color: state.primaryTextColor, fontSize: width * 3.3))),
    );
  }

  final String _message =
      "Henüz hiçbir etkinliğin yok. Yeni bir etkinlik oluşturmak ister misin? Artı işaretine basman yeterli.";

  PreferredSize _appBar(
      {required double width,
      required BuildContext context,
      required MyPostState state}) {
    return PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
            backgroundColor: constants.appBarColor.withOpacity(0.9),
            title: Row(
              children: [
                Text(
                  state.currentUser!.userName!,
                  style: GoogleFonts.gentiumBookBasic(
                      textStyle:
                          TextStyle(fontSize: width * 6, color: Colors.white)),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _addPostButton(
                        context: context,
                        currentUser: const User(
                            name: "bla", joinedAt: '', id: "", lastName: ""),
                        width: width),
                    _archiveButton(context: context),
                  ],
                ))
              ],
            )));
  }

  IconButton _addPostButton(
      {required BuildContext context,
      required User currentUser,
      required double width}) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(CustomPageRoute(
            child: NewPostScreen(
          bottomNavBarCubit: widget.bottomNavBarCubit,
        )));
      },
      icon: Icon(
        CustomIcons.plus,
        size: width * 5,
      ),
      splashRadius: 20,
    );
  }

  Widget _archiveButton({required BuildContext context}) {
    return IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ArchiveScreen(
                      archiveBloc: context.read<ArchiveBloc>(),
                      dataRepo: context.read<DataRepository>(),
                    )));
          },
          icon: const Icon(Icons.archive_rounded),
          splashRadius: 20.0,
        );
  }
}
