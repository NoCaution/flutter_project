import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../models/user.dart';

class PostRepository{
  final FirebaseFirestore reference = FirebaseFirestore.instance;
  static final PostRepository _singleton= PostRepository._internal();

  factory PostRepository(){
    return _singleton;
  }

  PostRepository._internal();

  Future<void> addPost(Post? post, User? user) async {
    var ref = reference.collection("posts");
    var documentReference = await ref.add(post!.toMap());
    updatePost(Post(
        id: documentReference.id,
        whatToDo: post.whatToDo,
        description: post.description,
        userId: user?.id));
  }

  Stream<QuerySnapshot> getStream() {
    var ref = reference.collection("posts").snapshots();
    return ref;
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
      var e = snapshot.docs.single.data();
      return Post.fromMap(e);
    });
  }
}