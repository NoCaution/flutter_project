import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/services/post_services.dart';
import 'package:untitled1/services/user_services.dart';
import 'package:untitled1/session_cubit.dart';
import 'package:untitled1/widgets/post_card_widget.dart';
import '../models/user.dart';

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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/100;
    double height = MediaQuery.of(context).size.height/100;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 123, 78, 0.9),
          centerTitle: true,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
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
              ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.archive_rounded),splashRadius: 20.0,),
                IconButton(onPressed: (){}, icon: const Icon(Icons.message_rounded),splashRadius: 20.0,),
              ],
            )

            ]),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: DemoMessageScreen(sessionCubit: widget.sessionCubit,),

        ),
            //TextButton(
            //onPressed: () {
              //widget.authRepo?.signOut();
              //widget.sessionCubit?.showAuth();
            //},
            //child: const Text("çıkış yap"),
          //),
      ),
    );
  }
}

class DemoMessageScreen extends StatelessWidget{
  final SessionCubit? sessionCubit;
  DemoMessageScreen({Key? key,this.sessionCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var user = sessionCubit?.getCurrentUser;
    return Container(
      child: PostCardWidget(user: user,),
    );
  }

}
