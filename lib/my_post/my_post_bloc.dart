import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_credantial_repository.dart';
import '../auth/auth_repository.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../session_cubit.dart';
import 'my_post_event.dart';
import 'my_post_state.dart' as s;

class MyPostBloc extends Bloc<MyPostScreenEvent, s.MyPostScreenState> {
  final UserCredentialRepository userCredential;
  MyPostBloc({required this.userCredential}) : super(s.MyPostScreenState(currentUser: userCredential.user,currentPost: userCredential.post)) {
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
            userId: " ");
        PostRepository().addPost(post, state.currentUser);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
      }
    });

    on<GetCurrentUser>((event, emit) {
      User user = userCredential.user!;
      emit(state.copyWith(currentUser: user));
    });
  }
}
