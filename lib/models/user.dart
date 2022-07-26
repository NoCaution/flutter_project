import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String? name;
  final String? lastName;
  final String? birth;
  final String? eMail;
  final String? password;
  final String? mobile;
  final String? imageUrl;
  final bool? autoLogin;

  const User(
      {this.id,
      this.name,
      this.lastName,
      this.birth,
      this.eMail,
      this.password,
      this.mobile,
      this.imageUrl,
      this.autoLogin});

  User copyWith(
      {String? id,
      String? name,
      String? lastName,
      String? birth,
      String? eMail,
      String? password,
      String? mobile,
      String? imageUrl,
      bool? autoLogin}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        birth: birth ?? this.birth,
        eMail: eMail ?? this.eMail,
        password: password ?? this.password,
        mobile: mobile ?? this.mobile,
        imageUrl: imageUrl ?? this.imageUrl,
        autoLogin: autoLogin ?? this.autoLogin);
  }

  User.fromMap(dynamic map)
      : id = map["id"],
        name = map["name"],
        lastName = map["lastName"],
        birth = map["birth"],
        eMail = map["eMail"],
        password = map["password"],
        mobile = map["mobile"],
        imageUrl = map["imageUrl"],
        autoLogin = map["autoLogin"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["lastName"] = lastName;
    map["birth"] = birth;
    map["eMail"] = eMail;
    map["password"] = password;
    map["mobile"] = mobile;
    map["imageUrl"] = imageUrl;
    map["autoLogin"] = autoLogin;
    return map;
  }

  User.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["name"],
        lastName = doc.data()!["lastName"],
        birth = doc.data()!["birth"],
        eMail = doc.data()!["Email"],
        password = doc.data()!["password"],
        mobile = doc.data()!["mobile"],
        imageUrl = doc.data()!["imageUrl"],
        autoLogin = doc.data()!["autoLogin"];
}
