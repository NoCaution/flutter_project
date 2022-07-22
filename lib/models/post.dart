import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:untitled1/models/user.dart';


class Post {
  String? id;
  String? whatToDo;
  String? description;
  int? age1;
  int? age2;
  String? location;
  String? userId;
  List<User?>? likes;

  factory Post(
      {String? id,
      String? whatToDo,
      String? description,
      int? age1,
      int? age2,
      String? location,
      String? userId,
      List<User?>? likes}) {
    return Post._internal(
        id: id,
        whatToDo: whatToDo,
        description: description,
        age1: age1,
        age2: age2,
        location: location,
        userId: userId,
        likes: likes);
  }

  Post._internal(
      {this.id,
      this.whatToDo,
      this.description,
      this.age1,
      this.age2,
      this.location,
      this.userId,
      this.likes});

  Post.fromMap(dynamic o) {
    List<User>? users;
    if (o[likes] != null) {
      for (var i = 0; i < o["likes"].length; i++) {
        users?.add((User.fromMap(o["likes"][i])));
      }
    }
    id = o["id"];
    whatToDo = o["whatToDo"];
    description = o["description"];
    age1 = o["age1"];
    age2 = o["age2"];
    location = o["location"];
    userId = o["userId"];
    likes = o["likes"] == null ? [null] : users;
  }

  Post.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<User>? users;
    if (doc.data()![likes] != null) {
      for (var i = 0; i < doc.data()![likes].length; i++) {
        users?.add(User.fromMap(doc.data()!["likes"][i]));
      }
    }

    id = doc.id;
    whatToDo = doc.data()!["whatToDo"];
    description = doc.data()!["description"];
    age1 = doc.data()!["age1"];
    age2 = doc.data()!["age2"];
    location = doc.data()!["location"];
    userId = doc.data()!["userId"];
    likes = doc.data()!["likes"] == null ? [null] : users;
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> users = [];
    var map = <String, dynamic>{};
    for (var i = 0; i < likes!.length; i++) {
      users.add(likes![i]!.toMap());
    }
    map["id"] = id;
    map["whatToDo"] = whatToDo;
    map["description"] = description;
    map["age1"] = age1;
    map["age2"] = age2;
    map["location"] = location;
    map["userId"] = userId;
    map["likes"] = users;
    return map;
  }
}
