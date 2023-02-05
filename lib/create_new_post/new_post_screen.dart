import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/create_new_post/new_post_description_field.dart';
import 'package:untitled1/create_new_post/new_post_screen_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_state.dart' as s;
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import 'package:untitled1/utils/custom_icons.dart';
import '../models/user.dart';
import 'custom_dialog.dart';

class NewPostScreen extends StatefulWidget {
  final User currentUser;

  const NewPostScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewPostScreenState();
  }
}

class NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    Color color = constants.primaryTextColor.withOpacity(0.75);
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    User currentUser = widget.currentUser;
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      appBar: _appBar(context: context, color: color, width: width),
      body: BlocProvider<NewPostScreenBloc>(
          create: (context) => NewPostScreenBloc(
              userCredential: context.read<UserCredentialRepository>()),
          child: BlocBuilder<NewPostScreenBloc, s.NewPostScreenState>(
              builder: (context, state) {
            return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 20,left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Yeni Etkinlik",style: GoogleFonts.gentiumBookBasic(textStyle: textStyle(constants.primaryTextColor, width),fontSize: width*6),),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 40,
                        width: width * 93,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                _circleAvatar(currentUser, width, height), // avatar
                                Text(
                                  currentUser.name!,
                                  style: textStyle(color, width * 4),
                                ), // user name
                                const SizedBox(width: 7),
                                Text(
                                  currentUser.lastName!,
                                  style: textStyle(color, width * 4),
                                ),
                                // user last name
                              ],
                            ),
                            _thinLinePart(),
                            //thin divider
                            _descriptionPart(width: width, height: height, color: color),
                            //description part
                            _whatToDoPart(width: width, height: height, color: color),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
          }),
        ),
    );
  }

  PreferredSize _appBar({required BuildContext context,required Color? color,required double width}) {
    return PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                _showDialog(context);
              }, icon: Icon(CustomIcons.cancel,size: width*6,)),
          title: Text("Etkinlik Oluştur",style: GoogleFonts.gentiumBookBasic(textStyle: TextStyle(color: Colors.white,fontSize: width*6)),),
          backgroundColor: constants.appBarColor,
        ));
  }

  TextStyle textStyle(Color? color, double? width) {
    return TextStyle(
        fontSize: width, color: color, fontWeight: FontWeight.bold);
  }

  Widget _circleAvatar(User user, double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: CircleAvatar(
          backgroundImage:
              const AssetImage("lib/assets/images/imageflutter.jpeg"),
          backgroundColor: constants.appBarColor.withOpacity(0.9),
          radius: width * 8,
          child: user.imageUrl! == " "
              ? Text(
                  user.name!.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: width * 7,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                )),
    );
  }

  Padding _whatToDoPart(
      {required double height, required double width, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        height: height * 6,
        width: width * 75,
        padding: const EdgeInsets.all(10),
        child: const Text("form koy!"),
      ),
    );
  }

  Container _descriptionPart(
      {required double width, required double height, required Color color}) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 30, right: 30),
      child: const SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: NewPostDescriptionFormField(),
      ),
    );
  }

  Widget _thinLinePart() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 30,
      ),
      child: Container(
        height: 0.2,
        color: Colors.black45,
      ),
    );
  }

  _showDialog(BuildContext context) {
    continueCallBack() => {
          Navigator.of(context).pop(),
        };
    CustomDialog alert = CustomDialog(continueCallBack: continueCallBack);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
