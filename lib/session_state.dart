

import 'models/user.dart';

abstract class SessionState{}

class UnknownMainScreenState extends SessionState{}

class Authenticated extends SessionState{
  final User? user;
  final User? selectedUser;
  Authenticated({this.user,this.selectedUser});
}

class UnAuthenticated extends SessionState{}