import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/create_new_post/new_post_state.dart';
import 'package:untitled1/create_new_post/new_post_screen_events.dart';
import 'package:untitled1/create_new_post/new_post_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import '../models/post.dart';
import '../models/user.dart';

class NewPostBloc extends Bloc<NewPostScreenEvents,NewPostState>{
  final User currentUser;
  NewPostBloc({required this.currentUser}) : super(NewPostState(currentUser: currentUser)){
    on<NewPostWhatToDoChanged>((event, emit)async{
      emit(state.copyWith(whatToDo: event.whatToDo));
    });

    on<NewPostDescriptionChanged>((event,emit)async{
      emit(state.copyWith(description: event.description));
    });

    on<PostSubmitted>((event,emit)async{
      try{
        var user = currentUser;
        emit(state.copyWith(postStatus:NewPostSubmitted()));
        var post = Post(
          id: "",
          whatToDo: state.whatToDo,
          description: state.description,
          userId: currentUser.id,
          createdAt: "",
        );
        await PostRepository().addPost(post, currentUser);
        emit(state.copyWith(postStatus: NewPostSubmissionSuccess()));
      }catch(e){
        emit(state.copyWith(postStatus: NewPostSubmissionFailed(exception: e as Exception)));
      }
    });
  }
}
