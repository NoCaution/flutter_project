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
    var sentTo = reference.collection("messages").doc(message.messageSentTo);
    var ref1 = await sentTo.get();
    var sentBy = reference.collection("messages").doc(message.messageSentBy?.uid);
    var ref2 = await sentBy.get();
    List<Message>? messages = [message];
    if(ref1.data()!.isNotEmpty){
      ref1.data()?.addAll(message.toMap());
      sentTo.update(ref1.data() as Map<String,dynamic>);
    }
    else{
      sentTo.set({ for (var element in messages) element.messageSentTo! : {"messageSentBy": element.messageSentBy,"message" : element.message,"date": element.date} });
    }
    if(ref2.data()!.isNotEmpty){
      ref2.data()?.addAll(message.toMap());
      sentBy.update(ref2.data() as Map<String,dynamic>);
    }
    else{
      sentBy.set({ for (var element in messages) element.messageSentTo! : {"messageSentBy": element.messageSentBy,"message" : element.message,"date": element.date} });
    }
  }

  Future<void> deleteMessage(Message message)async{
    var ref = reference.collection("messages").doc(message.messageSentTo);
    var ref2 = await ref.get();
    ref2.data()?.removeWhere((key, value) => value == message.message);
    ref.update(ref2.data() as Map<String,dynamic>);
  }

  Future<List<Message>?> getMessagesByUserId(String? uid) async {
    List<Message>? messages;
    var ref = await reference.collection("messages").doc(uid).get();
    var data = ref.data()!;
    if(data.isNotEmpty){
      for(var i =0; i< data.length; i++){
        messages?.add(Message.fromMap(ref.data()![i]));
      }
    }
    return messages;
  }
}
