import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/create_new_post/new_post_screen_state.dart';
import 'package:untitled1/create_new_post/new_post_screen_events.dart';
import 'package:untitled1/create_new_post/new_post_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import '../models/post.dart';

class NewPostScreenBloc extends Bloc<NewPostScreenEvents,NewPostScreenState>{
  final UserCredentialRepository userCredential;
  NewPostScreenBloc({required this.userCredential}) : super(NewPostScreenState(currentUser: userCredential.user)){
    on<PostWhatToDoChanged>((event, emit)async{
      emit(state.copyWith(whatToDo: event.whatToDo));
    });

    on<PostDescriptionChanged>((event,emit)async{
      emit(state.copyWith(description: event.description));
    });

    on<PostSubmitted>((event,emit)async{
      try{
        var currentUser = userCredential.user;
        emit(state.copyWith(postStatus:NewPostSubmitted()));
        var post = Post(
          id: "",
          whatToDo: state.whatToDo,
          description: state.description,
          userId: currentUser?.id,
          createdAt: "",
        );
        await PostRepository().addPost(post, userCredential.user);
        emit(state.copyWith(postStatus: NewPostSubmissionSuccess()));
      }catch(e){
        emit(state.copyWith(postStatus: NewPostSubmissionFailed(exception: e as Exception)));
      }
    });
  }
}
