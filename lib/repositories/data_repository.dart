import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:flutter/material.dart';

class DataRepository {
  final firebase_user.FirebaseAuth authReference = firebase_user.FirebaseAuth.instance;
  String? capitalizeFirstLetter(String? word) {
    return word!
        .replaceFirst(word.substring(0, 1), word.substring(0, 1).toUpperCase());
  }

  void showMessage({String? message, BuildContext? context}) {
    final snackBar = SnackBar(
      content: Text(
        message!,
        style: const TextStyle(fontSize: 15, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[400],
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 40, left: 5, right: 5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide.none,
      ),
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}
