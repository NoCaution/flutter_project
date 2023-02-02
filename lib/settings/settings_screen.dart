import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/settings/settings_navigator_cubit.dart';
import 'package:untitled1/utils/constants.dart' as constants;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: constants.backGroundColor.withOpacity(0.5),
      appBar: _appBar(width: width),
      body: BlocProvider(
        create: (context) => SettingsNavigatorCubit(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _accountItem(width: width, context: context),
            _privacyItem(width: width, context: context),
          ],
        ),
      ),
    );
  }

  //COMPONENTS

  ListTile _accountItem(
      {required double width, required BuildContext context}) {
    return ListTile(
      leading: const Icon(Icons.account_box_outlined),
      horizontalTitleGap: 0,
      title: Text(
        "Hesap",
        style: GoogleFonts.gentiumBookBasic(
            textStyle: TextStyle(
                color: constants.primaryTextColor,
                fontSize: width * 5)),
      ),
      trailing: _arrowIcon(width),
      onTap: () {
        context.read<SettingsNavigatorCubit>().showAccount();
      },
    );
  }
  
  ListTile _privacyItem(
      {required double width, required BuildContext context}) {
    return ListTile(
      leading: const Icon(Icons.privacy_tip_sharp),
      horizontalTitleGap: 0,
      title: Text(
        "Gizlilik",
        style: GoogleFonts.gentiumBookBasic(
            textStyle: TextStyle(
                color: constants.primaryTextColor,
                fontSize: width * 5)),
      ),
      trailing: _arrowIcon(width),
      onTap: () {
        context.read<SettingsNavigatorCubit>().showPrivacy();
      },
    );
  }
  Icon _arrowIcon(double width){
    return Icon(
      Icons.arrow_forward_ios_rounded,
      size: width * 3.5,
      color: Colors.grey[400],
    );
  }

  PreferredSize _appBar({required double width}) {
    return PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          centerTitle: true,
          backgroundColor: constants.appBarColor.withOpacity(0.9),
          title: Text(
            "Ayarlar",
            style: GoogleFonts.gentiumBookBasic(
                textStyle: TextStyle(color: Colors.white, fontSize: width * 6)),
          ),
        ));
  }
}
