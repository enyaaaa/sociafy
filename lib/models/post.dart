import 'package:flutter/material.dart';

class Post{
  String username;
  String userprofilePic;
  String timeAgo;
  String? image;
  String? caption;
  String? location;
  var isliked;
  int likecount;
  int commentcount;
  String? likedby;
  var issaved;

  Post({
    required this.username,
    required this.userprofilePic,
    required this.timeAgo,
    this.image,
    this.caption,
    this.location,
    this.isliked,
    required this.likecount,
    required this.commentcount,
    this.likedby,
    this.issaved
  });
}

List<Post> posts = [
  Post(
    username: "tomholland2013",
    userprofilePic: "assets/users/tomholland2013.jpg",
    timeAgo: "3 mins",
    image: null,
    caption: "Amazing weekend having the family come out and surprise me. If you want to come out to LA for the Spiderman Far from home premier head to the link in my bio. I hope it’s your lucky day.",
    location: null,
    isliked: false,
    likecount: 0,
    commentcount: 0,
    likedby: null,
    issaved: false,
  ),
  Post(
    username: "corbynbesson",
    userprofilePic: "assets/users/corbynbesson.jpg",
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
  Post(
    username: "seaveydaniel",
    userprofilePic: "assets/users/seaveydaniel.jpg",
    timeAgo: "10 min",
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

