import 'dart:core';
import '../models/user.dart';
import 'new_post_status.dart';

class NewPostState {
  final String? whatToDo;
  final String? description;
  final User? currentUser;
  final NewPostStatus postStatus;

  NewPostState({
    this.whatToDo,
    this.description,
    this.currentUser,
    this.postStatus = const InitNewPostStatus(),
  });

  NewPostState copyWith({
    String? whatToDo,
    String? description,
    User? currentUser,
    NewPostStatus? postStatus,
  }) {
    return NewPostState(
        whatToDo: whatToDo ?? this.whatToDo,
        description: description ?? this.description,
        currentUser: currentUser ?? this.currentUser,
        postStatus: postStatus ?? this.postStatus);
  }
}
