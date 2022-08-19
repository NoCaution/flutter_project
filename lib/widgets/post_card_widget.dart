import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import '../models/post.dart';
import '../models/user.dart';

class PostCardWidget extends StatefulWidget {
  final Post? post;
  final User? user;
  final DataRepository? dataRepo;

  const PostCardWidget({Key? key, this.post, this.user,this.dataRepo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PostCardWidgetState();
  }
}

class PostCardWidgetState extends State<PostCardWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    User? user = widget.user;
    String? userName = widget.dataRepo?.capitalizeFirstLetter(user!.name!);
    String? userLastName = widget.dataRepo?.capitalizeFirstLetter(user!.lastName!);
    Color color = constants.primaryTextColor.withOpacity(0.75);
    return Container(
      width: width * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              _circleAvatar(user!, width, height),  // avatar
              const SizedBox(
                width: 20,
              ),
              Text(userName!,style: textStyle(color, width*4),), // user name

              const SizedBox(width: 7),

              Text(userLastName!,style: textStyle(color, width*4),), // user last name
            ],
          ),
          _thinLinePart(), //thin divider

          _descriptionPart(width: width, height: height, color: color), //description part

          _whatToDoPart(width: width, height: height, color: color), //whatToDo part

          _likeButton(), //like button

          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

//COMPONENTS
  Widget _circleAvatar(User user, double width, double height) {
    return CircleAvatar(
        backgroundImage: AssetImage("lib/assets/images/imageflutter.jpeg"),
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
              ));
  }
  TextStyle textStyle(Color? color, double? width){
    return TextStyle(
        fontSize: width,
        color: color,
        fontWeight: FontWeight.bold);
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
        child: Text(widget.post!.whatToDo!,
            style: GoogleFonts.gentiumBasic(
                textStyle: TextStyle(fontSize: width * 3.3, color: color))),
        padding: const EdgeInsets.all(10),
      ),
    );
  }

  Padding _likeButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(Icons.favorite_border_outlined),
        ],
      ),
    );
  }

  Container _descriptionPart(
      {required double width, required double height, required Color color}) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 30, top: 20, bottom:30,right: 30),
      child: Text(
        "   "+widget.post!.description!,
        style: GoogleFonts.gentiumBasic(
            textStyle: TextStyle(fontSize: width * 3.3, color: color)),
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
}
