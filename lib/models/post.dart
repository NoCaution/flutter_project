import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? whatToDo;
  String? description;
  int? age1;
  int? age2;
  String? location;
  String? userId;
  Post(
      {this.id,
      this.whatToDo,
      this.description,
      this.age1,
      this.age2,
      this.location,
      this.userId});

  Post.fromMap(dynamic o) {
    id = o["id"];
    whatToDo = o["whatToDo"];
    description = o["description"];
    age1 = o["age1"];
    age2 = o["age2"];
    location = o["location"];
    userId = o["userId"];
  }

  Post.fromDocumentSnapshot(DocumentSnapshot<Map<String,dynamic>> doc){
    id = doc.id;
    whatToDo = doc.data()!["whatToDo"];
    description = doc.data()!["description"];
    age1 = doc.data()!["age1"];
    age2 = doc.data()!["age2"];
    location = doc.data()!["location"];
    userId = doc.data()!["userId"];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["whatToDo"] = whatToDo;
    map["description"] = description;
    map["age1"] = age1;
    map["age2"] = age2;
    map["location"] = location;
    map["userId"]= userId;
    return map;
  }
}
