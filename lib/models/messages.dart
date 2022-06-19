import 'dart:math';

class Messages {
  String username;
  String userprofilePic;
  DateTime messageDate;
  String dateMessage;
  String message;

  Messages({
    required this.username,
    required this.userprofilePic,
    required this.messageDate,
    required this.dateMessage,
    required this.message,
  });
}

List<Messages> messages = [
  Messages(
    username: "corbynbesson",
    userprofilePic: "assets/users/corbynbesson.jpg",
    messageDate: DateTime.now(),
    message: "",
    dateMessage: "",
  ),
  Messages(
    username: "haileybieber",
    userprofilePic: "assets/users/haileybieber.jpg",
    messageDate: DateTime.now(),
    message: "",
    dateMessage: "",
  ),
  Messages(
    username: "tomholland2013",
    userprofilePic: "assets/users/tomholland2013.jpg",
    messageDate: DateTime.now(),
    message: "",
    dateMessage: "",
  ),
];

class Helpers{
  static final random = Random();

  static DateTime randomDate(){
    final random = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }
}