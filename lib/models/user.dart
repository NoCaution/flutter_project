import 'package:cloud_firestore/cloud_firestore.dart';
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

  User(
      {this.id,
      this.name,
      this.lastName,
      this.birth,
      this.eMail,
      this.password,
      this.mobile,
      this.imageUrl,});

  User.fromMap(dynamic o) {
    id = o["id"];
    name = o["name"];
    lastName = o["lastName"];
    birth = (o["birth"] as Timestamp).toDate();
    eMail = o["eMail"];
    password = o["password"];
    mobile = o["mobile"];
    imageUrl = o["imageUrl"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["lastName"] = lastName;
    map["birth"] = birth;
    map["eMail"] = eMail;
    map["password"] = password;
    map["mobile"] = mobile;
    map["imageUrl"]= imageUrl;
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
  }
}