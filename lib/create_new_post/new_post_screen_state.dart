import 'dart:core';
import '../models/user.dart';
import 'new_post_status.dart';

class NewPostScreenState {
  final String? whatToDo;
  final String? description;
  final User? currentUser;
  final NewPostStatus postStatus;

  NewPostScreenState({
    this.whatToDo,
    this.description,
    this.currentUser,
    this.postStatus = const InitNewPostStatus(),
  });

  NewPostScreenState copyWith({
    String? whatToDo,
    String? description,
    User? currentUser,
    NewPostStatus? postStatus,
  }) {
    return NewPostScreenState(
        whatToDo: whatToDo ?? this.whatToDo,
        description: description ?? this.description,
        currentUser: currentUser ?? this.currentUser,
        postStatus: postStatus ?? this.postStatus);
  }
}
