import 'dart:math';

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
    required this.isSentByMe
  });
}


List<Messages> chats = [
  Messages(
    sender: corbynbesson,
    datetime: DateTime.now().subtract(Duration(minutes: 10)),
    text: "hello!",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: harrystyles,
    datetime: DateTime.now().subtract(Duration(hours: 5)),
    text: "hello!",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "hello!",
    unread: false,
    isSentByMe: false,
  ),
];

List<Messages> messages = [
  Messages(
    sender: corbynbesson,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "whatsup",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: corbynbesson,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "i am so happy",
    unread: true,
    isSentByMe: true,
  ),
  Messages(
    sender: currentUser,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "what you doing",
    unread: true,
    isSentByMe: false,
  ),
  Messages(
    sender: oliviarodrigo,
    datetime: DateTime.now().subtract(Duration(days: 1, minutes: 4)),
    text: "woo hoo",
    unread: true,
    isSentByMe: true,
  ),
];