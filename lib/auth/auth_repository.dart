import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled1/repositories/user_repository.dart';
import 'package:untitled1/validators/validations.dart';
import '../../models/user.dart';
import '../repositories/data_repository.dart';
import 'form_submission_status.dart';


class AuthRepository {
  final DataRepository dataRepo;
  AuthRepository({required this.dataRepo});
  String? attemptAutoLogin() {
    var result = UserRepository().getCurrentUserUid();
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
    return await UserRepository().signIn(eMail, password);
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
    var user = User(id: "",name: name, lastName: lastName,birth: "" ,eMail: eMail, password: password,mobile: "",imageUrl: "",userName: "");
    UserRepository().createUser(user);
    return user;
  }

  Future<void> doesUserExist(String? eMail) async {
    await UserRepository().getUserByEmail(eMail);
  }

  Future<void> signOut() async {
    UserRepository().signOut();
  }

  Future<User?> getCurrentUser()async{
    String? id = UserRepository().getCurrentUserUid().toString();
    return await UserRepository().getUserById(id);
  }

  Future<bool> sendOtp({String? eMail}) async{
    return await EmailAuth(sessionName: "session")
        .sendOtp(recipientMail: eMail!.trim());
  }

  void printException(
      {required FormSubmissionStatus? formStatus, BuildContext? context,String? pickerType}) {
    String? message;
    if(pickerType == "login"){
      message = Validations().loginExceptionPicker(formStatus: formStatus);
    }
    if(pickerType == "signUp"){
      message = Validations().signupExceptionPicker(formStatus: formStatus);
    }
    if(pickerType == "eMailVerify"){
      message = Validations().verifyEmailExceptionPicker(formStatus!);
    }
    if (message != null) {
      dataRepo.showMessage(
          message: message, context: context); //exceptionPicker in validations
    }
  }
}