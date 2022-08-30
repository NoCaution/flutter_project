import '../models/post.dart';
import '../models/user.dart';

class UserCredentialRepository {
  User? user;
  Post? post;
  List<Post>? archivedPosts;
  UserCredentialRepository({this.user,this.post,this.archivedPosts});
}



