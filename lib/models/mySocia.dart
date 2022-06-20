import 'package:flutter/material.dart';

class mySocia{
  String username;
  String userprofilePic;
  DateTime timeAgo;
  String image;
  String caption;
  String location;
  var isliked;
  int likecount;
  int commentcount;
  String? likedby;

  mySocia({
    required this.username,
    required this.userprofilePic,
    required this.timeAgo,
    required this.image,
    required this.caption,
    required this.location,
    required this.isliked,
    required this.likecount,
    required this.commentcount,
    required this.likedby,
  });
}

class mySociaList with ChangeNotifier{
  List<mySocia> mySocias = [];

  List<mySocia> getmyPostList(){
    return mySocias;
  }

  void addSocia (newPost) {
    mySocias.insert(0, newPost);
  }

  void removePhoto(i){
    mySocias.removeAt(i);
    notifyListeners();
  }

  mySocia getLatestPost(){
    List<mySocia> temp = List.from(mySocias);
    temp.sort((a,b) {
      if(a.timeAgo.isBefore(b.timeAgo)) return 1;
      else return 0;
    });
    return temp[0];
  }
}