import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/post_status.dart';
import 'package:untitled1/services/user_services.dart';
import '../home/main_screen_state.dart';
import 'package:untitled1/home/main_screen_events.dart';
import 'package:untitled1/services/post_services.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  static final _singleton = MainScreenBloc._internal();

  factory MainScreenBloc() {
    return _singleton;
  }

  MainScreenBloc._internal() : super(MainScreenState()) {
    on<PullToRefresh>((event, emit) async {
      try {
        var posts = await PostService().getPosts();
        emit(state.copyWith(posts: posts));
        emit(state.copyWith(postStatus: GetPostsSuccessful()));
      } catch (e) {
        emit(state.copyWith(
            postStatus: GetPostsFailed(exception: e as Exception)));
      }
    });

    on<Refresh>((event,emit)async{
      try{
        emit(state.copyWith(postStatus: GettingPosts()));
        var posts = await PostService().getPosts();
        emit(state.copyWith(posts: posts));
        emit(state.copyWith(postStatus: GetPostsSuccessful()));
      }catch(e){
        emit(state.copyWith(postStatus: GetPostsFailed(exception: e as Exception)));
      }
    });

    on<GetCurrentUser>((event, emit) async {
      var currentUser = await UserService().getUserById(firebaseUser?.uid);
      emit(state.copyWith(currentUser: [currentUser!]));
    });

    on<GetCurrentUserPost>((event, emit) async {
      var currentUserPost = await PostService().getPostById(firebaseUser?.uid);
      emit(state.copyWith(currentUserPost: [currentUserPost!]));
    });
  }
}
