import 'models/user.dart';

abstract class MainScreenState{}

class UnknownMainScreenState extends MainScreenState{}

class Authenticated extends MainScreenState{
  final User? user;
  Authenticated({this.user});
}

class UnAuthenticated extends MainScreenState{}