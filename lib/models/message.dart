import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class Message{
  final String? messageSentTo;
  final User? messageSentBy;
  final String? message;
  final String? date;

  const Message({this.messageSentTo,this.messageSentBy,this.message,this.date});

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};
    map["messageSentTo"] = messageSentTo!;
    map["messageSentBy"]= messageSentBy;
    map["message"]= message;
    map["date"]= date;
    return map;
  }

  Message.fromMap(dynamic o) :
    messageSentTo= o["messageSentTo"],
    messageSentBy = o["messageSentBy"],
    message = o["message"],
    date = o["date"];


  Message.fromDocumentSnapshot(DocumentSnapshot<Map<String,dynamic>> doc) :
    messageSentTo = doc.data()!["messageSentTo"],
    messageSentBy = doc.data()!["messageSentBy"],
    message = doc.data()!["message"],
    date= doc.data()!["date"];

}