import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'add_post_event.dart';
import 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc({required User currentUser})
      : super(AddPostState(currentUser: currentUser)) {
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
        PostRepository().addPost(post, state.currentUser);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
      }
    });
  }
}
