import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled1/services/user_methods.dart';
import 'package:untitled1/services/user_services.dart';
import '../../models/user.dart';

class AuthRepository {

  String? attemptAutoLogin() {
    var result = UserMethods().isUserSignedIn();
    if(result != null){
      return result ;
    }
    else{
      return "";
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
    var user = User(id: "",name: name, lastName: lastName,birth: DateTime(2022,12,30,0,0) ,eMail: eMail, password: password,mobile: "",imageUrl: "",);
    UserMethods().createUser(user);
    return user;
  }

  Future<void> userExist(String? eMail) async {
    await UserService().getUserByEmail(eMail);
  }

  Future<void> signOut() async {
    UserMethods().signOut();
  }
}
