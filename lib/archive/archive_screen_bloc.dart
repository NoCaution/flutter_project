import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/archive/archive_screen_event.dart';
import 'package:untitled1/home/post_status.dart';
import 'package:untitled1/repositories/post_repository.dart';
import '../repositories/user_credential_repository.dart';
import 'archive_screen_state.dart' as s;

class ArchiveScreenBloc extends Bloc<ArchiveScreenEvent, s.ArchiveScreenState> {
  final UserCredentialRepository userCredential;

  ArchiveScreenBloc({required this.userCredential})
      : super(s.ArchiveScreenState(currentUser: userCredential.user)) {

    on<GetArchivedPosts>((event, emit) async {
      try {
        emit(state.copyWith(postsStatus: GettingPosts()));
        var posts = await PostRepository().getArchivedPostsById(userCredential.user!.id);
        emit(state.copyWith(postsStatus: GetPostsSuccessful(),archivedPosts: posts));
        userCredential.archivedPosts = posts;
      } catch (e) {
        emit(state.copyWith(
            postsStatus: GetPostsFailed(exception: e as Exception)));
      }
    });
  }
}
