import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/create_new_post/new_post_description_field.dart';
import 'package:untitled1/create_new_post/new_post_screen_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_events.dart';
import 'package:untitled1/create_new_post/new_post_screen_state.dart' as s;
import 'package:untitled1/create_new_post/new_post_what_to_do_field.dart';
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
  var formKey = GlobalKey<FormState>();

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
                  padding: const EdgeInsets.only(top: 15, bottom: 20, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Yeni Etkinlik",
                        style: GoogleFonts.gentiumBookBasic(
                            textStyle:
                                textStyle(constants.primaryTextColor, width),
                            fontSize: width * 6),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 38,
                  width: width * 93,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _circleAvatar(currentUser, width, height),
                          // avatar
                          _name(
                              currentUser: currentUser,
                              color: color,
                              width: width),
                          // user name
                          const SizedBox(width: 7),
                          _lastName(
                              currentUser: currentUser,
                              color: color,
                              width: width),
                          // user last name
                        ],
                      ),
                      _thinLinePart(),
                      _form(width: width, height: height, color: color),
                      _submitButton(context: context, width: width),
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

  PreferredSize _appBar(
      {required BuildContext context,
      required Color? color,
      required double width}) {
    return PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                _showDialog(context);
              },
              icon: Icon(
                CustomIcons.cancel,
                size: width * 6,
              )),
          title: Text(
            "Etkinlik Oluştur",
            style: GoogleFonts.gentiumBookBasic(
                textStyle: TextStyle(color: Colors.white, fontSize: width * 6)),
          ),
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

  Text _name(
      {required User currentUser,
      required Color color,
      required double width}) {
    return Text(
      currentUser.name!,
      style: textStyle(color, width * 4),
    );
  }

  Text _lastName(
      {required User currentUser,
      required Color color,
      required double width}) {
    return Text(currentUser.lastName!, style: textStyle(color, width * 4));
  }

  Padding _whatToDoPart(
      {required double height, required double width, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        height: height * 6,
        width: width * 75,
        padding: const EdgeInsets.all(10),
        child: const NewPostWhatToDoFormField(),
      ),
    );
  }

  Container _descriptionPart(
      {required double width, required double height, required Color color}) {
    return Container(
      height: width * 20,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 30, right: 30),
      child: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: NewPostDescriptionFormField(),
      ),
    );
  }

  Form _form(
      {required double width, required double height, required Color color}) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _descriptionPart(width: width, height: height, color: color),
          _whatToDoPart(width: width, height: height, color: color),
        ],
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

  Row _submitButton({required BuildContext context, required double width}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: _buttonStyle(),
          onPressed: () => _onPressed(context),
          child: Text(
            "Paylaş",
            style: GoogleFonts.gentiumBookBasic(
                textStyle: TextStyle(
                    color: constants.primaryTextColor.withOpacity(0.6)),
                fontSize: width * 4),
          ),
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }

  _onPressed(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      context.read<NewPostScreenBloc>().add(PostSubmitted());
      Navigator.of(context).pop();
    }
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.only(left: 30, right: 30)),
        backgroundColor: MaterialStateProperty.all(Colors.white70),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide.none,
        )));
  }
}
