import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/login/auth_repository.dart';
import 'package:untitled1/main_screen_cubit.dart';
import 'package:untitled1/widgets/post_card_widget.dart';

class MainScreen extends StatefulWidget {
  final AuthRepository? authRepo;
  final MainScreenCubit? mainScreenCubit;
  const MainScreen({Key? key,this.mainScreenCubit,this.authRepo}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 123, 78, 0.9),
          centerTitle: true,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Meet",
              style: GoogleFonts.kanit(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 32)),
            ),
            Text("Up",
                style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(255, 222, 118, 1),
                        fontSize: 32))),
          ])),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: TextButton(
            onPressed: (){
              widget.authRepo?.signOut();
              widget.mainScreenCubit?.showAuth();
            },
            child: Text("çıkış yap"),
          ),
        ),
    );
  }
}