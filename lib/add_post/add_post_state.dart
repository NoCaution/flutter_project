import 'dart:ui';
import '../auth/form_submission_status.dart';
import '../home/post_status.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'package:untitled1/utils/constants.dart'as constants;

class AddPostState {
  final String? description;
  final String? whatToDo;
  final FormSubmissionStatus formStatus;
  final PostStatus postStatus;
  final User? currentUser;
  final Color? primaryTextColor;


  AddPostState({
    this.description,
    Color? primaryTextColor,
    this.whatToDo,
    FormSubmissionStatus? formStatus,
    PostStatus? postStatus,
    this.currentUser,
  })  : postStatus= const InitialPostStatus(),
        formStatus = const InitialFormStatus(),
        primaryTextColor = constants.primaryTextColor.withOpacity(0.75);

  AddPostState copyWith({
    String? description,
    String? whatToDo,
    PostStatus? postStatus,
    FormSubmissionStatus? formStatus,
    Post? newPost,
    User? currentUser,
  }) {
    return AddPostState(
        description: description ?? this.description,
        whatToDo: whatToDo ?? this.whatToDo,
        postStatus: postStatus?? this.postStatus,
        formStatus: formStatus ?? this.formStatus,
        currentUser: currentUser ?? this.currentUser);
  }
}
