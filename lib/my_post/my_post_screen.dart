import 'package:flutter/material.dart';

class MyPostScreen extends StatefulWidget{
  const MyPostScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyPostScreenState();
  }

}

class MyPostScreenState extends State<MyPostScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Etkinliğim"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}