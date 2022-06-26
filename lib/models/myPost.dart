import 'package:flutter/material.dart';

//models for my own post
class myPost{
  String username;
  String userprofilePic;
  DateTime timeAgo;
  String image;
  String? caption;
  String? location;
  var isliked;
  var issaved;

  myPost({
    required this.username,
    required this.userprofilePic,
    required this.timeAgo,
    required this.image,
    required this.caption,
    required this.location,
    required this.isliked,
    this.issaved
  });
}

//post list with change notifier where user can create their post
class myPostList with ChangeNotifier{
  List<myPost> myPosts = [];


  List<myPost> getmyPostList(){
    return myPosts;
  }

  void addPost(myPost newPost) {
    myPosts.insert(0, newPost);
  }

  void removePhoto(i){
    myPosts.removeAt(i);
    notifyListeners();
  }
}