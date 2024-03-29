import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final String? whatToDo;
  final String? description;
  final String? userId;
  final bool? archived;
  final String? createdAt;

  const Post({
    this.id,
    this.whatToDo,
    this.description,
    this.userId,
    this.archived,
    this.createdAt,
  });

  Post.fromMap(dynamic o)
      : id = o["id"],
        whatToDo = o["whatToDo"],
        description = o["description"],
        userId = o["userId"],
        archived = o["archived"],
        createdAt = o["createdAt"];

  Post.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        whatToDo = doc.data()!["whatToDo"],
        description = doc.data()!["description"],
        userId = doc.data()!["userId"],
        archived = doc.data()!["archived"],
        createdAt = doc.data()!["createdAt"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["whatToDo"] = whatToDo;
    map["description"] = description;
    map["userId"] = userId;
    map["archived"] = archived;
    map["createdAt"] = createdAt;
    return map;
  }
}
