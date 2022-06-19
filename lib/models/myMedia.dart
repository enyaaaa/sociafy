import 'package:flutter/material.dart';

class myPost{
  String username;
  String userprofilePic;
  DateTime timeAgo;
  String image;
  String caption;
  String location;
  var isliked;
  int likecount;
  int commentcount;

  myPost({
    required this.username,
    required this.userprofilePic,
    required this.timeAgo,
    required this.image,
    required this.caption,
    required this.location,
    required this.isliked,
    required this.likecount,
    required this.commentcount,
  });
}

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