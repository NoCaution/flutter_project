import 'message.dart';

class Chat{
  final List<Message>? messages;
  final Message? lastMassage;
  final String? profilePic;
  final String? userName;

  const Chat({this.messages,this.lastMassage,this.profilePic,this.userName});
}