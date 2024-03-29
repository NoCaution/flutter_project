import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import '../models/post.dart';
import '../models/user.dart';

class PostCardWidget extends StatefulWidget {
  final Post post;
  final String userInfoForPost;
  final DataRepository dataRepo;
  final bool? onHome;
  final bool? archived;

  const PostCardWidget({Key? key, required this.post, required this.userInfoForPost,required this.dataRepo, this.onHome, this.archived}) : super(key: key);

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
    List<String> userInfo = widget.userInfoForPost.split(" ");
    String? userName = userInfo[0];
    String? userLastName = userInfo[1];
    String? userImageUrl = userInfo[2];
    Color color = constants.primaryTextColor.withOpacity(0.75);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: width * 93,
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
                _circleAvatar(userName,userImageUrl, width, height),  // avatar
                Text(userName,style: textStyle(color, width*4),), // user name
                const SizedBox(width: 7),
                Text(userLastName,style: textStyle(color, width*4),), // user last name
              ],
            ),
            _thinLinePart(), //thin divider
            _descriptionPart(width: width, height: height, color: color), //description part
            _whatToDoPart(width: width, height: height, color: color), //whatToDo part
            widget.onHome ==true
                ? _likeButton()
                : widget.archived == true
                ? const SizedBox(height: 0,width: 0,)
                : _editButton(),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

//COMPONENTS
  Widget _circleAvatar(String userName,String  userImageUrl, double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 20),
      child: CircleAvatar(
          backgroundImage: AssetImage("lib/assets/images/imageflutter.jpeg"),
          backgroundColor: constants.appBarColor.withOpacity(0.9),
          radius: width * 8,
          child: userImageUrl == " "
              ? Text(
                  userName.substring(0, 1).toUpperCase(),
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
  TextStyle textStyle(Color? color, double? width){
    return TextStyle(
        fontSize: width,
        color: color,
        fontWeight: FontWeight.bold);
  }
  

  Padding _whatToDoPart(
      {required double height, required double width, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        height: height * 6,
        width: width * 75,
        padding: const EdgeInsets.all(10),
        child: Text(widget.post.whatToDo!,
            style: GoogleFonts.gentiumBookBasic(
                textStyle: TextStyle(fontSize: width * 3.3, color: color))),
      ),
    );
  }

  Padding _likeButton() {
    return const Padding(
      padding: EdgeInsets.only(right: 30, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.favorite_border_outlined),
        ],
      ),
    );
  }

  Padding _editButton() {
    return const Padding(
      padding: EdgeInsets.only(right: 30, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.edit),
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
        "   ${widget.post.description!}",
        style: GoogleFonts.gentiumBookBasic(
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
