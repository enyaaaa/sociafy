import 'package:flutter/material.dart';
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

List<Posts> posts = [
  Posts(
    user: corbynbesson,
    timeAgo: "10 min",
    image: "assets/post/corbynbesson_post.jpg",
    caption: "I'm flying",
    location: "Coachella, California",
    isliked: false,
    likecount: 0,
    commentcount: 0,
    likedby: null,
    issaved: false,
  ),
  Posts(
    user: seaveydaniel,
    timeAgo: "2h",
    image: "assets/post/seaveydaniel_post.jpg",
    caption: null,
    location: "californa",
    isliked: false,
    likecount: 0,
    commentcount: 0,
    likedby: null,
    issaved: false,
  ),
];

