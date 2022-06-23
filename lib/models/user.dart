import 'package:sociafy/models/stories.dart';

class User{
  String image;
  String username;
  String name;
  String bio;
  int totalPost;
  int totalFollower;
  int totalFollowing;

  User ({
    required this.image,
    required this.username,
    required this.name,
    required this.bio,
    required this.totalPost,
    required this.totalFollower,
    required this.totalFollowing,
  });
}
