import 'package:sociafy/models/user.dart';

class Messages {
  User sender;
  DateTime datetime;
  String text;
  bool unread;
  bool isSentByMe;

  Messages({
    required this.sender,
    required this.datetime,
    required this.text,
    required this.unread,
    required this.isSentByMe,
  });
}