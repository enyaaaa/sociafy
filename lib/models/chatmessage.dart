import 'package:flutter/material.dart';

class Chatmessage {
  String text;
  DateTime date;
  bool isSentByMe;

  Chatmessage({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });
}

List<Chatmessage> chatmessages = [
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 3)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 2, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 6, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 5)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 3)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 2, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 6, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 5)),
    isSentByMe: true,
  ),Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 3)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 2, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 6, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 5)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 3)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 2, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 6, minutes: 4)),
    isSentByMe: false,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 4)),
    isSentByMe: true,
  ),
  Chatmessage(
    text: "yes Sure",
    date: DateTime.now().subtract(Duration(days: 7, minutes: 5)),
    isSentByMe: true,
  ),
];

class ChatMessageList with ChangeNotifier{


  List<Chatmessage> getChatMessagesList(){
    return chatmessages;
  }

  void addMessage(Chatmessage newMessage) {
    chatmessages.insert(0, newMessage);
  }

  void removePhoto(i){
    chatmessages.removeAt(i);
    notifyListeners();
  }
}

