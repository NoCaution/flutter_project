import '../models/post.dart';

abstract class NewPostScreenEvents{}

class NewPostWhatToDoChanged extends NewPostScreenEvents{
  final String? whatToDo;
  NewPostWhatToDoChanged({this.whatToDo});
}

class NewPostDescriptionChanged extends NewPostScreenEvents{
  final String? description;
  NewPostDescriptionChanged({this.description});
}

class PostSubmitted extends NewPostScreenEvents{}