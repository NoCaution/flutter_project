

import 'models/user.dart';

abstract class SessionState{}

class UnknownMainScreenState extends SessionState{}

class Authenticated extends SessionState{
  final User? user;
  Authenticated({this.user});
}

class UnAuthenticated extends SessionState{}