import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class MessageRepository{
  final FirebaseFirestore reference = FirebaseFirestore.instance;
  static final MessageRepository _singleton = MessageRepository._internal();
  factory MessageRepository(){
    return _singleton;
  }
  MessageRepository._internal();


  Future<void> sendMessage(Message message) async {
    String? date = DateTime.now().toString();
    var sentTo = reference
        .collection("messages")
        .doc(message.messageSentTo)
        .collection("specificMessages");
    var sentBy = reference
        .collection("messages")
        .doc(message.messageSentBy?.id)
        .collection("specificMessages");
    Message? messageConverted = const Message().copyWith(
      messageSentTo: message.messageSentTo,
      messageSentBy: message.messageSentBy,
      message: message.message,
      date: date,);
    await sentTo.add(messageConverted.toMap());
    await sentBy.add(messageConverted.toMap());
  }

  Future<void> deleteMessage(Message message) async {
    var ref = reference
        .collection("messages")
        .doc(message.messageSentTo)
        .collection("specificMessages")
        .where("message", isEqualTo: message);
  }

  Future<List<Message>?> getMessagesByUserId(
      {String? messageSentTo, String? messageSentBy}) async {
    //messageSentTo = current user's id
    List<Message>? messages;
    var ref = await reference
        .collection("messages")
        .doc(messageSentTo)
        .collection("specificMessages")
        .get();
    var data = ref.docs
        .where((element) =>
    Message.fromDocumentSnapshot(element).messageSentBy?.id ==
        messageSentBy ||
        Message.fromDocumentSnapshot(element).messageSentTo ==
            messageSentBy)
        .toList();
    for (var i = 0; i < data.length; i++) {
      messages?.add(Message.fromDocumentSnapshot(data[i]));
    }
    messages?.sort((a, b) {
      return a.date!.compareTo(b.date!);
    });
    return messages;
  }
}