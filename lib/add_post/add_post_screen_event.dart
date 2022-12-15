import 'package:untitled1/add_post/add_post_screen_state.dart';
import 'package:untitled1/home/main_screen_events.dart';

import '../models/post.dart';
import '../models/user.dart';

abstract class AddPostScreenEvent{}

class PostDescriptionChanged extends AddPostScreenEvent{
  final String? description;
  PostDescriptionChanged({this.description});
}

class PostWhatToDoChanged extends AddPostScreenEvent{
  final String? whatToDo;
  PostWhatToDoChanged({this.whatToDo});
}

class PostSubmitted extends AddPostScreenEvent{}