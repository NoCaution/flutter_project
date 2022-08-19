

import 'models/post.dart';
import 'models/user.dart';

abstract class SessionState{}

class UnknownMainScreenState extends SessionState{}

class Authenticated extends SessionState{
  final User? user;
  final Post? post;
  Authenticated({this.user,this.post});
}

class UnAuthenticated extends SessionState{}