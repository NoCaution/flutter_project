import 'package:untitled1/home/main_screen_events.dart';

import '../models/user.dart';

abstract class MyPostScreenEvent{}

class PostDescriptionChanged extends MyPostScreenEvent{
  final String? description;
  PostDescriptionChanged({this.description});
}

class PostWhatToDoChanged extends MyPostScreenEvent{
  final String? whatToDo;
  PostWhatToDoChanged({this.whatToDo});
}

class GetCurrentUser extends MyPostScreenEvent{
  final User? user;
  GetCurrentUser({this.user});
}

class PostSubmitted extends MyPostScreenEvent{}