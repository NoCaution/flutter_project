import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'add_post_screen_event.dart';
import 'add_post_screen_state.dart' as s;

class AddPostBloc extends Bloc<AddPostScreenEvent, s.AddPostScreenState> {
  final UserCredentialRepository userCredential;
  AddPostBloc({required this.userCredential}) : super(s.AddPostScreenState(currentUser: userCredential.user,newPost: userCredential.post)) {
    on<PostDescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<PostWhatToDoChanged>((event, emit) {
      emit(state.copyWith(whatToDo: event.whatToDo));

    });

    on<PostSubmitted>((event, emit) {
      emit(state.copyWith(formStatus: FormSubmitted()));
      try {
        Post post = Post(
            id: "",
            whatToDo: state.whatToDo,
            description: state.description,
            userId: state.currentUser!.id);
        userCredential.post=post;
        PostRepository().addPost(post, state.currentUser);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
      }
    });

  }
}
