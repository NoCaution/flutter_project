import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post.dart';
import '../models/user.dart';

class PostCardWidget extends StatefulWidget {
  final Post? post;
  final User? user;

  const PostCardWidget({Key? key, this.post, this.user}) : super(key: key);

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
    String? userName = user!.name?.replaceFirst(
        user.name!.substring(0, 1), user.name!.substring(0, 1).toUpperCase());
    String? userLastName = user.lastName?.replaceFirst(
        user.lastName!.substring(0, 1),
        user.lastName!.substring(0, 1).toUpperCase());
    Color color = const Color.fromRGBO(0, 0, 0, 0.75);
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
              circleAvatar(user, width, height),  // avatar
              const SizedBox(
                width: 20,
              ),
              customText(color: color, width: width, text: userName), // user name
              const SizedBox(width: 7),
              customText(color: color, width: width, text: userLastName), // user last name
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 30,
            ),
            child: Container(
              height: 0.2,
              color: Colors.black45,
            ),
          ),
          descriptionPart(width: width, height: height, color: color), //description part here

          whatToDoPart(width: width, height: height, color: color), //whatToDo part here

          likeButton(), //like button here
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget circleAvatar(User user, double width, double height) {
    return CircleAvatar(
        backgroundImage: AssetImage(user.imageUrl!),
        backgroundColor: const Color.fromRGBO(255, 123, 78, 0.9),
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

  Text customText({Color? color, double? width, String? text}) {
    return Text(text!,
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                fontSize: width! * 4,
                color: color,
                fontWeight: FontWeight.bold)));
  }

  Padding whatToDoPart(
      {required double height, required double width, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 45, top: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        height: height * 6,
        width: width * 70,
        child: Text(widget.post!.whatToDo!,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: width * 3, color: color))),
        padding: const EdgeInsets.all(10),
      ),
    );
  }

  Padding likeButton() {
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

  Container descriptionPart(
      {required double width, required double height, required Color color}) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 40,right: 30),
      child: Text(
        "   "+widget.post!.description!,
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: width * 3, color: color)),
      ),
    );
  }
}
