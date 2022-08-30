import 'dart:ui';
import '../auth/form_submission_status.dart';
import '../home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'package:untitled1/utils/constants.dart'as constants;

class AddPostScreenState {
  final String? description;
  final String? whatToDo;
  final FormSubmissionStatus formStatus;
  final PostStatus postStatus;
  final Post? newPost;
  final User? currentUser;
  final Color? primaryTextColor;


  AddPostScreenState({
    String? description,
    Color? primaryTextColor,
    String? whatToDo,
    FormSubmissionStatus? formStatus,
    PostStatus? postStatus,
    Post? newPost,
    required User? currentUser,
  })  : description = description,
        whatToDo = whatToDo,
        postStatus= const InitialPostStatus(),
        formStatus = const InitialFormStatus(),
        newPost = newPost,
        currentUser = currentUser,
        primaryTextColor = constants.primaryTextColor.withOpacity(0.75);

  AddPostScreenState copyWith({
    String? description,
    String? whatToDo,
    PostStatus? postStatus,
    FormSubmissionStatus? formStatus,
    Post? newPost,
    User? currentUser,
  }) {
    return AddPostScreenState(
        description: description ?? this.description,
        whatToDo: whatToDo ?? this.whatToDo,
        postStatus: postStatus?? this.postStatus,
        formStatus: formStatus ?? this.formStatus,
        newPost: newPost ?? this.newPost,
        currentUser: currentUser ?? this.currentUser);
  }
}
