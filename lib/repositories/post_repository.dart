import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../models/user.dart';

class PostRepository {
  final FirebaseFirestore reference = FirebaseFirestore.instance;
  static final PostRepository _singleton = PostRepository._internal();

  factory PostRepository() {
    return _singleton;
  }

  PostRepository._internal();

  Future<void> addPost(Post? post, User? user) async {
    final DateTime date = DateTime.now();
    var ref = reference.collection("posts");
    var documentReference = await ref.add(post!.toMap());
    var now = convertDateTime(dateTime: date);
    updatePost(Post(
      id: documentReference.id,
      whatToDo: post.whatToDo,
      description: post.description,
      userId: user?.id,
      archived: false,
      createdAt: now,
    ));
  }
  Future<void> deletePost(String? postId) {
    var ref = reference.collection("posts").doc(postId).delete();
    return ref;
  }

  Future<List<Post>>? getPosts() async {
    var snapshot = await reference.collection("posts").get();
    return snapshot.docs
        .map((documentSnapshot) => Post.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Future<void> updatePost(Post post) async {
    var ref = reference.collection("posts").doc(post.id);
    ref.update(post.toMap());
  }

  Future<Post>? getPostById(String? userId) async {
    var ref = reference.collection("posts");
    return await ref.where("userId", isEqualTo: userId).get().then((snapshot) {
      return Post.fromMap(snapshot.docs.single.data());
    });
  }

  Future<List<Post>?> getArchivedPostsById(String? userId) async {
    return await reference
        .collection("posts")
        .where("userId", isEqualTo: userId)
        .where("archived", isEqualTo: true)
        .get()
        .then((snapshot) {
      List<Post>? archivedPosts = [];
      for (var snapshots in snapshot.docs) {
        archivedPosts.add(Post.fromDocumentSnapshot(snapshots));
      }
      return archivedPosts;
    });
  }
  String convertDateTime({required DateTime dateTime}){
    return "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.day.toString().padLeft(2,'0')} ${dateTime.hour.toString().padLeft(2,'0')}-${dateTime.minute.toString().padLeft(2,'0')}";
  }
}
