import 'package:flutter/material.dart';

class PasswordForgotScreen extends StatefulWidget {
  const PasswordForgotScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PasswordForgotScreenState();
  }
}

class PasswordForgotScreenState extends State<PasswordForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Şifremi unuttum"),
      ),
    );
  }
}
