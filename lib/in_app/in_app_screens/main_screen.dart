import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/session_cubit.dart';
import '../../models/user.dart';

class MainScreen extends StatefulWidget {
  final AuthRepository? authRepo;
  final SessionCubit? mainScreenCubit;

  const MainScreen({
    Key? key,
    this.mainScreenCubit,
    this.authRepo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  User? user;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: TextButton(
          onPressed: () {
            widget.authRepo?.signOut();
            widget.mainScreenCubit?.showAuth();
          },
          child: const Text("çıkış yap"),
        ),
      ),
    );
  }
}
