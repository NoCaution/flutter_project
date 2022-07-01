import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/post.dart';

class User {
  String? id;
  String? name;
  String? lastName;
  DateTime? birth;
  String? eMail;
  String? password;
  String? mobile;
  String? imageUrl;
  Post? post;
  bool? autoLogin;

  User(
      {
      this.id,
      this.name,
      this.lastName,
      this.birth,
      this.eMail,
      this.password,
      this.mobile,
      this.imageUrl,
      this.autoLogin
      });

  User.fromMap(dynamic o) {
    id = o["id"];
    name = o["name"];
    lastName = o["lastName"];
    birth = (o["birth"] as Timestamp).toDate();
    eMail = o["eMail"];
    password = o["password"];
    mobile = o["mobile"];
    imageUrl = o["imageUrl"];
    autoLogin = o["autoLogin"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["lastName"] = lastName;
    map["birth"] = birth;
    map["eMail"] = eMail;
    map["password"] = password;
    map["mobile"] = mobile;
    map["imageUrl"]= imageUrl;
    map["autoLogin"]= autoLogin;
    return map;
  }
  User.fromDocumentSnapshot(DocumentSnapshot<Map<String,dynamic>> doc){
    id = doc.id;
    name = doc.data()!["name"];
    lastName = doc.data()!["lastName"];
    birth = doc.data()!["birth"];
    eMail = doc.data()!["eMail"];
    password = doc.data()!["password"];
    mobile = doc.data()!["mobile"];
    imageUrl = doc.data()!["imageUrl"];
    autoLogin = doc.data()!["autoLogin"];
  }
}
