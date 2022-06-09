import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:untitled1/services/user_services.dart';
import '../models/user.dart' ;
class UserMethods{
  static final UserMethods _singleton= UserMethods._internal();
  final firebase_user.FirebaseAuth authReference = firebase_user.FirebaseAuth.instance;

  factory UserMethods(){
    return _singleton;
  }
  UserMethods._internal();

  Future<User?> signIn(String? eMail,String? password)async{
    var user = await authReference.signInWithEmailAndPassword(email: eMail!, password: password!);
    var user2 = await UserService().getUserByEmail(user.user?.email);
    return user2;
  }

  Future<void> signOut()async{
    return await authReference.signOut();
  }

  Future<User?> createUser(User? user1)async{
    var result =await authReference.createUserWithEmailAndPassword(email: user1!.eMail! , password: user1.password!);
    var user = User(id: result.user!.uid,name: user1.name,lastName: user1.lastName,birth: user1.birth,eMail: user1.eMail,password: user1.password,mobile: user1.mobile,imageUrl: user1.imageUrl,);
    await UserService().addUser(user);
    return user;
  }

  String? getCurrentUserUid(){
    var result = authReference.currentUser;
    return result?.uid;
  }



}