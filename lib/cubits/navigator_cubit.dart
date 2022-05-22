import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post.dart';

class NavigatorCubit extends Cubit<Post?>{
  final selectedPost = Post();

  NavigatorCubit():super(null);

  void showPostDetails(Post post){
    emit(post);
  }
  void popToPosts(){
    emit(null);
  }
}