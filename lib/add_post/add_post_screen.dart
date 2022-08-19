import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget{
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPostScreenState();
  }

}

class AddPostScreenState extends State<AddPostScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni etkinlik oluştur"),
      ),
    );
  }
}