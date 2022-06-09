import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class MessageService {
  final FirebaseFirestore reference = FirebaseFirestore.instance;
  static final _singleton = MessageService._internal();

  factory MessageService() {
    return _singleton;
  }

  MessageService._internal();

  Future<void> sendMessage(Message message)async{
    var ref = reference.collection("messages");
    await ref.add(message.toMap());
  }

  Future<void> deleteMessage(Message message)async{
    var ref = reference.collection("messages");
    await ref.doc(message.messageSentTo).delete();
  }

  Future<List<Message>?> getMessageByUserId(String? uid) async {
    List<Message>? messages;
    var ref = reference.collection("messages");
    await ref
        .where("messageSentTo", isEqualTo: uid)
        .orderBy("date", descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        var message = Message.fromMap(element);
        messages?.add(message);
      }
    });
    return messages;
  }
}
