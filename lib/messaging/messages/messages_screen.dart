import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/utils/constants.dart' as constants;
class MessagesScreen extends StatefulWidget{
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MessagesScreenState();
  }

}

class MessagesScreenState extends State<MessagesScreen>{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: _appBar(context: context,width: width),
    );
  }


  PreferredSize _appBar({required BuildContext context,required double width}){
    return PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          backgroundColor: constants.appBarColor,
          title: Text(
            "Mesajlar",
            style: GoogleFonts.gentiumBookBasic(
                textStyle: TextStyle(color: Colors.white, fontSize: width * 6)),
          ),
        ));
  }
}