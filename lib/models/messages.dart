import 'package:sociafy/models/user.dart';

//chats that user have texted with
class UserChats{
  UserModel userchats;
  DateTime datetime;
  String text;
  bool unread;

  UserChats({
    required this.userchats,
    required this.datetime,
    required this.text,
    required this.unread,
  });
}

//messgaes of the chats
class Messages {
  DateTime datetime;
  String text;
  bool unread;
  bool isSentByMe;

  Messages({
    required this.datetime,
    required this.text,
    required this.unread,
    required this.isSentByMe,
  });
}