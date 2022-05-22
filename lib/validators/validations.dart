class Validators{

  String? passwordValidator(String? password) {
    if (password == null) {
      return "Şifre girmelisin!";
    }
    if (password.length < 10) {
      return "şifre en az 10 karakter olmalı!";
    }
    if(password.length>15){
      return "şifre en fazla 15 karakter olabilir!";
    }
    else{
      return "";
    }
  }

  String? eMailValidator(String? eMail) {
    if (eMail == null) {
      return "bir Email girmelisin!";
    }
    if (isValidEmail(eMail) == false) {
      return "geçerli bir Email girmelisin!";
    }
    else{
      return "";
    }
  }

  bool isValidEmail(String eMail) {
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
    }
    else{
      return "";
    }
  }
}
 bool isNameValid(String? name){
  String pattern = r'^[a-z A-Z,.\-]+$';
  RegExp regex= RegExp(pattern);
  bool response = regex.hasMatch(name!);
  return response;

 }