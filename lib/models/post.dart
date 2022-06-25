import 'package:sociafy/models/user.dart';

class Posts{
  User user;
  DateTime timeAgo;
  String image;
  String? caption;
  String? location;
  bool isliked;
  String? likedby;
  bool issaved;

  Posts({
    required this.user,
    required this.timeAgo,
    required this.image,
    this.caption,
    this.location,
    required this.isliked,
    this.likedby,
    required this.issaved,

  });
}

class Comments {
  User user;
  String comment;
  DateTime datetime;
  bool isliked;

  Comments({
    required this.user,
    required this.comment,
    required this.isliked,
    required this.datetime,
  });
}