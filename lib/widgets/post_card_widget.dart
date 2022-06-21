import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/user.dart';


class PostCardWidget extends StatefulWidget{
  final Post? post;
  final User? user;
  const PostCardWidget({Key? key,this.post,this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PostCardWidgetState();
  }

}

class PostCardWidgetState extends State<PostCardWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}