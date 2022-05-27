import '../models/user.dart';

class AuthCredentials {
  final String? eMail;
  final String? name;
  final String? lastName;
  final String? password;
  final User? user;

  AuthCredentials({
    this.eMail,
    this.name,
    this.lastName,
    this.password,
    this.user,
  });
}
