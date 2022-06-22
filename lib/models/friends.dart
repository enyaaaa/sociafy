import 'package:sociafy/models/user.dart';

class Friends{
  User user;
  bool isfollowedByMe;

  Friends({
    required this.user,
    required this.isfollowedByMe,
  });
}