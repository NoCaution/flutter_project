import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget{
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MessagesScreenState();
  }

}

class MessagesScreenState extends State<MessagesScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mesajlar"),
      ),
    );
  }

}