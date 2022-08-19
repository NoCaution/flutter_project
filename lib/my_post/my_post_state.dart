import 'dart:ui';
import '../auth/form_submission_status.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'package:untitled1/utils/constants.dart'as constants;

class MyPostScreenState {
  final String? description;
  final String? whatToDo;
  final FormSubmissionStatus formStatus;
  final Post? currentPost;
  final User? currentUser;
  final Color? primaryTextColor;

  MyPostScreenState({
    String? description,
    Color? primaryTextColor,
    String? whatToDo,
    FormSubmissionStatus? formStatus,
    required Post? currentPost,
    required User? currentUser,
  })  : description = description,
        whatToDo = whatToDo,
        formStatus = const InitialFormStatus(),
        currentPost = currentPost,
        currentUser = currentUser,
        primaryTextColor = constants.primaryTextColor.withOpacity(0.75);

  MyPostScreenState copyWith({
    String? description,
    String? whatToDo,
    FormSubmissionStatus? formStatus,
    Post? currentPost,
    User? currentUser,
  }) {
    return MyPostScreenState(
        description: description ?? this.description,
        whatToDo: whatToDo ?? this.whatToDo,
        formStatus: formStatus ?? this.formStatus,
        currentPost: currentPost ?? this.currentPost,
        currentUser: currentUser ?? this.currentUser);
  }
}
