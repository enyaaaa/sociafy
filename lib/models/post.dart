import 'package:sociafy/models/friends.dart';
import 'package:sociafy/models/user.dart';

class Posts{
  User user;
  DateTime timeAgo;
  String image;
  String? caption;
  String? location;
  var isliked;
  String? likedby;
  var issaved;

  Posts({
    required this.user,
    required this.timeAgo,
    required this.image,
    this.caption,
    this.location,
    this.isliked,
    this.likedby,
    this.issaved
  });
}