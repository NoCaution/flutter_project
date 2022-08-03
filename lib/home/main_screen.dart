import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/data_repository.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/home/main_screen_bloc.dart';
import 'package:untitled1/home/main_screen_events.dart';
import 'package:untitled1/session_cubit.dart';
import 'package:untitled1/widgets/post_card_widget.dart';
import 'main_screen_state.dart';

class MainScreen extends StatefulWidget {
  final AuthRepository? authRepo;
  final SessionCubit? sessionCubit;

  const MainScreen({
    Key? key,
    this.sessionCubit,
    this.authRepo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  @override
  initState() {
    super.initState();
    MainScreenBloc().add(GetCurrentUser());
    MainScreenBloc().add(Refresh());
    MainScreenBloc().add(GetCurrentUserPost());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
        appBar: _appBar(context),
        body: BlocProvider<MainScreenBloc>(
            create: (context) => MainScreenBloc(),
            child: Container(
              height: height * 100,
              width: width * 100,
              color: const Color.fromRGBO(230, 230, 230, 1),
              padding: const EdgeInsets.all(13),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: postCardWidget(height),
              ),
            )));
  }
}

Widget postCardWidget(double height) {
  return BlocBuilder<MainScreenBloc, HomeScreenState>(
    builder: (context, state) {
      return PostCardWidget(
        user: state.currentUser,
        post: state.currentUserPost,
        dataRepo: DataRepository(),
      );
    },
  );
}
//COMPONENTS

PreferredSize _appBar(BuildContext context){
  return PreferredSize(
      preferredSize: AppBar().preferredSize,
      child: AppBar(
        backgroundColor: const Color.fromRGBO(255, 123, 78, 0.9),
        centerTitle: true,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Meet",
                  style: GoogleFonts.gentiumBasic(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 32)),
                ),
                Text("Up",
                    style: GoogleFonts.gentiumBasic(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(255, 222, 118, 1),
                            fontSize: 32)))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {BlocProvider.of<HomeNavigatorCubit>(context).showArchive();},
                icon: const Icon(Icons.archive_rounded),
                splashRadius: 20.0,
              ),
              IconButton(
                onPressed: () {BlocProvider.of<HomeNavigatorCubit>(context).showMessages();},
                icon: const Icon(Icons.message_rounded),
                splashRadius: 20.0,
              ),
            ],
          )
        ]),
      ));
}
