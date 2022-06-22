import 'package:sociafy/models/user.dart';

class Posts{
  User user;
  String timeAgo;
  String image;
  String? caption;
  String? location;
  var isliked;
  int likecount;
  int commentcount;
  String? likedby;
  var issaved;

  Posts({
    required this.user,
    required this.timeAgo,
    required this.image,
    this.caption,
    this.location,
    this.isliked,
    required this.likecount,
    required this.commentcount,
    this.likedby,
    this.issaved
  });
}