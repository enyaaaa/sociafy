import 'package:sociafy/models/user.dart';

class UserChats{
  User userchats;
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