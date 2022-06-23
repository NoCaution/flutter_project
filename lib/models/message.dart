import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class Message{
  String? messageSentTo;
  User? messageSentBy;
  String? message;
  DateTime? date;

  Message({this.messageSentTo,this.messageSentBy,this.message,this.date});

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};
    map["messageSentTo"] = messageSentTo!;
    map["messageSentBy"]= messageSentBy;
    map["message"]= message;
    map["date"]= date;
    return map;
  }

  Message.fromMap(dynamic o){
    messageSentTo= o["messageSentTo"];
    messageSentBy = o["messageSentBy"];
    message = o["message"];
    date = (o["date"] as Timestamp).toDate();
  }
}