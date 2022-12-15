import 'package:untitled1/add_post/post_submission_status.dart' as h;
import 'package:untitled1/add_post/post_submission_status.dart';
import '../auth/form_submission_status.dart';
import '../models/user.dart';

class AddPostScreenState {
  final String? description;
  final String? whatToDo;
  final FormSubmissionStatus formStatus;
  final h.PostSubmissionStatus postStatus;
  final User? currentUser;


  AddPostScreenState({
    this.description,
    this.whatToDo,
    this.formStatus= const InitialFormStatus(),
    this.postStatus = const h.InitialPostStatus(),
    this.currentUser,
  });

  AddPostScreenState copyWith({
    String? description,
    String? whatToDo,
    PostSubmissionStatus? postStatus,
    FormSubmissionStatus? formStatus,
    User? currentUser,
  }) {
    return AddPostScreenState(
        description: description ?? this.description,
        whatToDo: whatToDo ?? this.whatToDo,
        postStatus: postStatus ?? this.postStatus,
        formStatus: formStatus ?? this.formStatus,
        currentUser: currentUser ?? this.currentUser);
  }
}
