import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {
  final firebase_user.FirebaseAuth authReference =
      firebase_user.FirebaseAuth.instance;
  final FirebaseFirestore reference = FirebaseFirestore.instance;
  static final UserRepository _signleton = UserRepository._internal();

  factory UserRepository() {
    return _signleton;
  }

  UserRepository._internal();

  Future<User?> signIn(String? eMail, String? password) async {
    var user = await authReference.signInWithEmailAndPassword(
        email: eMail!, password: password!);
    var user2 = await getUserByEmail(user.user?.email);
    return user2;
  }

  Future<void> signOut() async {
    return await authReference.signOut();
  }

  Future<User?> createUser(User? user1) async {
    var result = await authReference.createUserWithEmailAndPassword(
        email: user1!.eMail!, password: user1.password!);
    var date = DateTime.now();
    var now = convertDateTime(dateTime: date);
    var user = User(
        id: result.user!.uid,
        name: user1.name,
        lastName: user1.lastName,
        birth: user1.birth,
        eMail: user1.eMail,
        password: user1.password,
        mobile: user1.mobile,
        imageUrl: user1.imageUrl,
        userName: user1.userName,
        joinedAt: now);
    await _addUser(user);
    return user;
  }

  String? getCurrentUserUid() {
    var result = authReference.currentUser;
    return result?.uid;
  }

  Future<void> _addUser(User? user) async {
    var ref = reference.collection("users");
    await ref.doc(user?.id).set(user!.toMap());
  }

  Future<void> deleteUser(String? id) {
    var ref = reference.collection("users").doc(id).delete();
    return ref;
  }

  Future<List<User>>? getUsers() async {
    var snapshot = await reference.collection("users").get();
    return snapshot.docs
        .map((documentSnapshot) => User.fromMap(documentSnapshot))
        .toList();
  }

  Future<User>? getUserByEmail(String? eMail) async {
    var ref = reference.collection("users");
    return await ref.where("eMail", isEqualTo: eMail).get().then((snapshot) {
      var user = snapshot.docs.first;
      return User.fromMap(user);
    });
  }

  Future<User>? getUserById(String? id) async {
    var ref = reference.collection("users");
    var document = await ref.doc(id).get();
    return User.fromMap(document.data());
  }

  Future<void> updateUser(User user) async {
    var ref = reference.collection("users").doc(user.id);
    ref.update(user.toMap());
  }
  String convertDateTime({required DateTime dateTime}){
    return "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.day.toString().padLeft(2,'0')} ${dateTime.hour.toString().padLeft(2,'0')}-${dateTime.minute.toString().padLeft(2,'0')}";
  }
}
