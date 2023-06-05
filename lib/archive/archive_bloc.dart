import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/post_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import '../models/user.dart';
import 'archive_event.dart';
import 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  final User? currentUser;
  ArchiveBloc({this.currentUser})
      : super(ArchiveState(currentUser: currentUser)) {
    on<GetArchivedPosts>((event, emit) async {
      try {
        emit(state.copyWith(postsStatus: GettingPosts()));
        var archivedPosts = await PostRepository().getArchivedPostsById(currentUser!.id);
        emit(state.copyWith(postsStatus: GetPostsSuccessful(),archivedPosts: archivedPosts));
      } catch (e) {
        emit(state.copyWith(
            postsStatus: GetPostsFailed(exception: e as Exception)));
      }
    });
  }
}
