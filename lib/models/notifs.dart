import 'package:sociafy/models/user.dart';

//models for notification according to the users
class Notifs{
  UserModel user;
  DateTime  datetime;
  String notiftype;
  String? postreact;
  String icon;

  Notifs({
    required this.user,
    required this.datetime,
    required this.notiftype,
    required this.postreact,
    required this.icon
  });
}