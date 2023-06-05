import 'package:untitled1/home/home_events.dart';

import '../models/user.dart';

abstract class AddPostEvent{}

class PostDescriptionChanged extends AddPostEvent{
  final String? description;
  PostDescriptionChanged({this.description});
}

class PostWhatToDoChanged extends AddPostEvent{
  final String? whatToDo;
  PostWhatToDoChanged({this.whatToDo});
}

class PostSubmitted extends AddPostEvent{}