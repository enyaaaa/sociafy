import 'package:sociafy/models/user.dart';

//models for search page
class Friends{
  User user;
  bool isfollowedByMe;

  Friends({
    required this.user,
    required this.isfollowedByMe,
  });
}