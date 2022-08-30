import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:flutter/material.dart';

import '../models/user.dart';

class DataRepository {
  final firebase_user.FirebaseAuth authReference = firebase_user.FirebaseAuth
      .instance;

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

  User? changeUserProperty(
      {required User user, String? property, String? value}) {
    return user.copyWith(
      id: property == "id" ? value : user.id,
      name: property == "name" ? value : user.name,
      lastName: property == "lastName" ? value : user.lastName,
      birth: property == "birth" ? value : user.birth,
      eMail: property == "eMail" ? value : user.eMail,
      password: property == "password" ? value : user.password,
      mobile: property == "mobile" ? value : user.mobile,
      imageUrl: property == "imageUrl" ? value : user.imageUrl,
      userName: property == "userName" ? value : user.userName,
      autoLogin: property == "autoLogin" ? value == "true" : user.autoLogin,
    );
  }

  String convertDateTime({required DateTime dateTime}) {
    return "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(
        2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour
        .toString().padLeft(2, '0')}-${dateTime.minute.toString().padLeft(
        2, '0')}";
  }

  String parseDateTime({required String date}) {
    List<String> hours = date.split(" ");
    List<String> dates = hours.first.split("-");
    String year = dates[0];
    String month = dates[1];
    String day = dates[2];
    String message;
    if (month == "01") {
      message = day + " Ocak " + year;
    }else if(month == "02"){
      message = day + " Şubat " + year;
    }else if(month == "03"){
      message = day + " Mart " + year;
    }else if(month== "04"){
      message = day + " Nisan " + year;
    }else if(month == "05"){
      message = day + " Mayıs " + year;
    } else if(month == "06"){
      message = day + " Haziran " + year;
    }else if(month == "07"){
      message = day + " Temmuz " + year;
    }else if(month == "08"){
      message = day + " Ağustos  " + year;
    }else if(month == "09"){
      message = day + " Eylül " + year;
    }else if(month == "10"){
      message = day + " Ekim " + year;
    }else if(month == "11"){
      message = day + " Kasım " + year;
    }else if(month == "12"){
      message = day + " Aralık " + year;
    }else{
      message = "";
    }
    return message;
  }
}