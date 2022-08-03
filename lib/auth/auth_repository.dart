import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled1/services/user_services.dart';
import '../../models/user.dart';
import '../services/user_methods.dart';


class AuthRepository {

  String? attemptAutoLogin() {
    var result = UserMethods().getCurrentUserUid();
    if(result != null){
      return result ;
    }
    else{
      return null;
    }
  }
  Future<User?> login({
    @required String? eMail,
    @required String? password,
  })async {
    return await UserMethods().signIn(eMail, password);
  }

  bool verify({String? eMail, String? code}) {
    return EmailAuth(sessionName: "session")
        .validateOtp(recipientMail: eMail!.trim(), userOtp: code!);
  }

  Future<User?> signUp({
    @required String? name,
    @required String? lastName,
    @required String? eMail,
    @required String? password,
  }) async {
    var user = User(id: " ",name: name, lastName: lastName,birth: " " ,eMail: eMail, password: password,mobile: " ",imageUrl: " ",);
    UserMethods().createUser(user);
    return user;
  }

  Future<void> doesUserExist(String? eMail) async {
    await UserService().getUserByEmail(eMail);
  }

  Future<void> signOut() async {
    UserMethods().signOut();
  }

  Future<User?> getCurrentUser()async{
    String? id = UserMethods().getCurrentUserUid().toString();
    return await UserService().getUserById(id);
  }
}