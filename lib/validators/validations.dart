import '../auth/form_submission_status.dart';

class Validations {
  String? loginExceptionPicker({FormSubmissionStatus? formStatus}) {
    if (formStatus is SubmissionFailed) {
      if (formStatus.exception.toString().split(" ")[0] ==
          "[firebase_auth/wrong-password]") {
        return "kullanıcı adı ya da şifre hatalı!";
      } else if (formStatus.exception.toString() == "null") {
        return formStatus.error!;
      } else if (formStatus.exception.toString().split(" ")[0] ==
          "[firebase_auth/user-not-found]") {
        return "kullanıcı adı ya da şifre hatalı!";
      } else if (formStatus.exception.toString().split(" ")[0] ==
          "[firebase_auth/too-many-requests]") {
        return "lütfen bir süre bekleyin..";
      } else {
        return formStatus.exception.toString();
      }
    }
    else{
      return null;
    }
  }

  String? signupExceptionPicker({FormSubmissionStatus? formStatus}){
      if (formStatus is SubmissionFailed) {
        return formStatus.error;
      }
      if (formStatus is SubmissionFailed &&
          formStatus.exception.toString() != "null") {
        return formStatus.exception.toString();
      }
      else{
        return null;
    }
  }
  //this one is same with above but there is going to be differences in time
  String? verifyEmailExceptionPicker(FormSubmissionStatus formStatus) {
    if (formStatus is SubmissionFailed) {
      return formStatus.error!;
    }
    if (formStatus is SubmissionFailed &&
        formStatus.exception.toString() != "null") {
      return formStatus.exception.toString();
    }
    else{
      return null;
    }
  }

  String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return "Şifre girmelisin!";
    }
    if (password.length < 10) {
      return "şifre en az 10 karakter olmalı!";
    }
    if (password.length > 15) {
      return "şifre en fazla 15 karakter olabilir!";
    } else {
      return null;
    }
  }

  String? eMailValidator(String? eMail) {
    if (eMail!.isEmpty) {
      return "bir Email girmelisin!";
    }
    if (isEmailValid(eMail) == false) {
      return "geçerli bir Email girmelisin!";
    } else {
      return null;
    }
  }

  bool isEmailValid(String eMail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(eMail)) ? false : true;
  }

  String? birthDateValidator(DateTime? date) {
    final present = DateTime.now();
    if (date == null) {
      return "doğum tarihi gerekli!";
    }
    if (!date.isBefore(DateTime(present.year, present.month, present.day))) {
      return "doğum tarihi gelecekte olamaz!";
    } else {
      return null;
    }
  }
}

bool isNameValid(String? name) {
  String pattern = r'^[a-z A-Z,.\-]+$';
  RegExp regex = RegExp(pattern);
  bool response = regex.hasMatch(name!);
  return response;
}
