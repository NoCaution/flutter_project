import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/utils/constants.dart' as constants;
class CustomDialog extends StatelessWidget {
  final VoidCallback continueCallBack;
  const CustomDialog({super.key, required this.continueCallBack});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: _title(width: width),
          content: _content(width: width),
          actions: [
            _continueButton(width: width, context:context),
            _cancelButton(width: width,context: context),
          ],
        ));
  }

  Text _content({required double width}){
    return Text("Devam ederseniz değişiklikleriniz kaydedilmeyecek. Onaylıyor musunuz?",
        style: GoogleFonts.gentiumBookBasic(textStyle: TextStyle(color: constants.primaryTextColor,fontSize: width*3.5 ))
    );
  }

  Text _title({required double width}){
    return Text("İptal",
        style: GoogleFonts.gentiumBookBasic(textStyle: TextStyle(color: constants.primaryTextColor,fontSize: width*5,fontWeight: FontWeight.bold ))
    );
  }

  TextButton _cancelButton({required double width,required BuildContext context}){
    return TextButton(
    child: Text("İptal",
        style: GoogleFonts.gentiumBookBasic(textStyle: TextStyle(color: constants.primaryTextColor,fontSize: width*3.5 ))
    ),
    onPressed:  () {
      Navigator.of(context).pop();
    },
    );
  }

  TextButton _continueButton({required double width,required BuildContext context}){
    return TextButton(
    child: Text("Devam",
      style: GoogleFonts.gentiumBookBasic(textStyle: TextStyle(color: constants.primaryTextColor,fontSize: width*3.5, ))
    ),
      onPressed:  () {
        Navigator.of(context).pop();
        continueCallBack();
      },
    );
  }
}