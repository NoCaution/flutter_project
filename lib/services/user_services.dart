import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final FirebaseFirestore reference = FirebaseFirestore.instance;
  static final UserService _singleton= UserService._internal();
  factory UserService(){
    return _singleton;
  }

  UserService._internal();

  Stream<QuerySnapshot> getStream(){
    var ref = reference.collection("users");
    var stream = ref.snapshots();
    return stream;
  }

  Future<void> addUser(User? user) async {
    var ref = reference.collection("users");
    var documentReference = await ref.doc(user?.id).set(user!.toMap());

  }

  Future<void> deleteUser(String? id) {
    var ref = reference.collection("users").doc(id).delete();
    return ref;
  }

  Future<List<User>>? getUsers() async{
    var snapshot = await reference.collection("users").get();
    return snapshot.docs.map((documentSnapshot) => User.fromDocumentSnapshot(documentSnapshot)).toList();
  }

  Future<User>? getUserByEmail(String? eMail)async{
    var ref = reference.collection("users");
    return await ref.where("eMail",isEqualTo: eMail).get().then((snapshot){
      var user = snapshot.docs.first;
      return User.fromMap(user);
    });
  }

  Future<User>? getUserById(String? id)async{
    var  ref = reference.collection("users");
    return await ref.doc(id).get().then((snapshot){
      var e = snapshot;
      return User.fromMap(e);
    });
  }
  Future<void> updateUser(User user)async{
    var ref = reference.collection("users").doc(user.id);
    ref.update(user.toMap());
  }
}
