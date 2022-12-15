import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/utils/constants.dart' as constants;
class AccountScreen extends StatefulWidget{
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AccountScreenState();
  }

}

class AccountScreenState extends State<AccountScreen>{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/100;
    double height = MediaQuery.of(context).size.height/100;
    return Scaffold(
      appBar: _appBar(width: width),
      body: Container(

      ),
    );
  }
  
  PreferredSize _appBar({required double width}){
    return PreferredSize(
        child:AppBar(
            backgroundColor: constants.appBarColor.withOpacity(0.9),
            centerTitle: true,
            title: Text(
              "Hesap",
              style: GoogleFonts.gentiumBasic(
                  textStyle:
                    TextStyle(color: Colors.white, fontSize: width*6)),
            )
        ),
        preferredSize: AppBar().preferredSize
    );
  }
}