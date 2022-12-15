import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/add_post/post_submission_status.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import '../models/post.dart';
import 'add_post_screen_event.dart';
import 'add_post_screen_state.dart' as s;

class AddPostBloc extends Bloc<AddPostScreenEvent, s.AddPostScreenState> {
  final UserCredentialRepository userCredential;
  final BottomNavigationBarCubit bottomNavBarCubit;

  AddPostBloc({required this.userCredential,required this.bottomNavBarCubit}) : super(s.AddPostScreenState(currentUser: userCredential.user)) {
    on<PostDescriptionChanged>((event, emit){
      emit(state.copyWith(description: event.description));

    });

    on<PostWhatToDoChanged>((event, emit){
      emit(state.copyWith(whatToDo: event.whatToDo));
    });
    on<PostSubmitted>((event,emit){
      emit(state.copyWith(formStatus: FormSubmitted()));
      var post = Post(
        id: "",
        description: state.description,
        whatToDo: state.whatToDo,
        userId: state.currentUser?.id,
      );
      try{
        PostRepository().addPost(post, state.currentUser);
        emit(state.copyWith(postStatus: PostSubmissionSuccess()));
        emit(state.copyWith(formStatus: SubmissionSuccess()));

      }catch(e){
        emit(state.copyWith(postStatus: PostSubmissionFailed(exception: e as Exception)));
        emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
      }
    });
  }
}
