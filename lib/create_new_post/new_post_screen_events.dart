import '../models/post.dart';

abstract class NewPostScreenEvents{}

class PostWhatToDoChanged extends NewPostScreenEvents{
  final String? whatToDo;
  PostWhatToDoChanged({this.whatToDo});
}

class PostDescriptionChanged extends NewPostScreenEvents{
  final String? description;
  PostDescriptionChanged({this.description});
}

class PostSubmitted extends NewPostScreenEvents{}