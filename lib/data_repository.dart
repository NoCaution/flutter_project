import 'package:untitled1/services/user_services.dart';

import 'models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_user;

class DataRepository {
  final firebase_user.FirebaseAuth authReference = firebase_user.FirebaseAuth.instance;
  String? capitalizeFirstLetter(String? word) {
    return word!
        .replaceFirst(word.substring(0, 1), word.substring(0, 1).toUpperCase());
  }


}
