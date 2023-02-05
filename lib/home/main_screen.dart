import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/home/main_screen_bloc.dart';
import 'package:untitled1/home/main_screen_events.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/session_cubit.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import 'package:untitled1/widgets/post_card_widget.dart';
import '../utils/custom_icons.dart';
import 'main_screen_state.dart';


class MainScreen extends StatefulWidget {
  final AuthRepository? authRepo;
  final SessionCubit? sessionCubit;
  final UserCredentialRepository userCredential;

  const MainScreen({
    Key? key,
    this.sessionCubit,
    this.authRepo,
    required this.userCredential,
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
        backgroundColor: constants.backGroundColor,
        appBar: _appBar(context,height),
        body: BlocProvider<MainScreenBloc>(
            create: (context) => MainScreenBloc(),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: postCardWidget(height),
                  ),
                ),
              ],
            )));
  }
}
//COMPONENTS

Widget postCardWidget(double height) {
  return BlocBuilder<MainScreenBloc, HomeScreenState>(
    builder: (context, state) {
      return PostCardWidget(
        user: state.currentUser,
        post: state.currentUserPost,
        dataRepo: context.read<DataRepository>(),
        onHome: true,
      );
    },
  );
}

PreferredSize _appBar(BuildContext context,double fontSize){
  return PreferredSize(
      preferredSize: AppBar().preferredSize,
      child: AppBar(
        backgroundColor: constants.appBarColor.withOpacity(0.9),
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
                  style: GoogleFonts.gentiumBookBasic(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: fontSize*3.3)),
                ),
                Text("Up",
                    style: GoogleFonts.gentiumBookBasic(
                        textStyle: TextStyle(
                            color: constants.appNameColor,
                            fontSize: fontSize*3.3)))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {BlocProvider.of<HomeNavigatorCubit>(context).showMessages();},
                icon: const Icon(CustomIcons.commentEmpty),
                splashRadius: 20.0,
              ),
            ],
          )
        ]),
      ));
}

