import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_state.dart' as s;
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/utils/constants.dart' as constants;

import '../models/user.dart';

class NewPostScreen extends StatefulWidget{
  final User currentUser;
  const NewPostScreen({Key? key, required this.currentUser}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NewPostScreenState();
  }

}

class NewPostScreenState extends State<NewPostScreen>{
  @override
  Widget build(BuildContext context) {
    Color color = constants.primaryTextColor.withOpacity(0.75);
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    User currentUser = widget.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("post ekle"),
      ),
      body: BlocProvider<NewPostScreenBloc>(
        create: (context)=>NewPostScreenBloc(userCredential: context.read<UserCredentialRepository>()),
          child:BlocBuilder<NewPostScreenBloc,s.NewPostScreenState>(
            builder: (context,state) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      _circleAvatar(currentUser, width, height),  // avatar
                      Text(currentUser.name!,style: textStyle(color, width*4),), // user name
                      const SizedBox(width: 7),
                      Text(currentUser.lastName!,style: textStyle(color, width*4),),
                      // user last name
                    ],
                  ),
                  _thinLinePart(), //thin divider
                  _descriptionPart(width: width, height: height, color: color), //description part
                  _whatToDoPart(width: width, height: height, color: color),
                ],
              );
            }
          ),
      ),
    );
  }

  TextStyle textStyle(Color? color, double? width){
    return TextStyle(
        fontSize: width,
        color: color,
        fontWeight: FontWeight.bold);
  }

Widget _circleAvatar(User user, double width, double height) {
  return Padding(
    padding: const EdgeInsets.only(left: 30,right: 20),
    child: CircleAvatar(
        backgroundImage: const AssetImage("lib/assets/images/imageflutter.jpeg"),
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
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        height: height * 6,
        width: width * 70,
        padding: const EdgeInsets.all(10),
        child: const Text("form koy!"),
      ),
    );
  }
  Container _descriptionPart(
      {required double width, required double height, required Color color}) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 30, top: 20, bottom:30,right: 30),
      child: const Text("form koy!"),
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
}