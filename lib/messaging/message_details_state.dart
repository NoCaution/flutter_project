import '../models/message.dart';
import '../models/user.dart';

class MessagingState{
  final User? targetUser;
  final List<Message>? messages;
  final User? currentUser;
  MessagingState({
    this.targetUser = const User(id: " ",name: " ",lastName: " ", birth: " ",eMail: " ",password: " ",mobile: " ",imageUrl: " ",autoLogin: false,userName: " ", joinedAt: ""),
    this.messages = const [Message(messageSentTo: " ",messageSentBy: User(id: " ",name: " ",lastName: " ", birth: " ",eMail: " ",password: " ",mobile: " ",imageUrl: " ",autoLogin: false,userName: " ", joinedAt: ""),message: " ",date: " "  )],
    this.currentUser = const User(id: " ",name: " ",lastName: " ", birth: " ",eMail: " ",password: " ",mobile: " ",imageUrl: " ",autoLogin: false,userName: " ", joinedAt: ""),
  });

  MessagingState copyWith({
  User? targetUser,
  List<Message>? messages,
  User? currentUser,
}){
    return MessagingState(
      targetUser: targetUser ?? this.targetUser,
      messages: messages ?? this.messages,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}