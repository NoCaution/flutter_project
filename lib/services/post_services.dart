import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../models/user.dart';
class PostService {
  final FirebaseFirestore reference = FirebaseFirestore.instance;
  static final _singleton = PostService._internal();

  factory PostService(){
    return _singleton;
  }
  PostService._internal();

  Future<void> addPost(Post? post,User? user)async{
    var ref = reference.collection("posts");
    var documentReference = await ref.add(post!.toMap());
    updatePost(Post(id: documentReference.id,whatToDo: post.whatToDo,description: post.description,age1: post.age1,age2: post.age2,location: post.location,userId: user?.id));
  }

  Stream<QuerySnapshot> getStream(){
    var ref = reference.collection("posts").snapshots();
    return ref;
  }

  Future<void> deletePost(String? postId){
    var ref = reference.collection("posts").doc(postId).delete();
    return ref;
  }

  Future<List<Post>>? getPosts()async{
    var snapshot = await reference.collection("posts").get();
    try{
      return snapshot.docs.map((documentSnapshot) => Post.fromDocumentSnapshot(documentSnapshot)).toList();
    }catch(e){
      rethrow;
    }
  }

  Future<void> updatePost(Post post)async{
    var ref = reference.collection("posts").doc(post.id);
    ref.update(post.toMap());
  }
  Future<Post>? getPostById(String? postId)async{
    var ref = reference.collection("posts");
    return await ref.where("userId",isEqualTo: postId).get().then((snapshot){
      var e = snapshot.docs.single.data();
      return Post.fromMap(e);
    }
    );
  }
}