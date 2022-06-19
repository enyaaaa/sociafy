import 'package:flutter/material.dart';

class Users{
  String image;
  String username;
  String name;
  String bio;
  int totalPost;
  int totalFollower;
  int totalFollowing;

  Users ({
    required this.image,
    required this.username,
    required this.name,
    required this.bio,
    required this.totalPost,
    required this.totalFollower,
    required this.totalFollowing,

  });
}

Users currentUser = Users(
    image: 'assets/users/zendaya.jpg',
    username: 'zendaya',
    name: '😂😱😩',
    bio: 'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
    totalPost: 0,
    totalFollower: 0,
    totalFollowing: 0
);

class UserList with ChangeNotifier{
  List<Users> user = [
    Users(
        image: 'assets/users/zendaya.jpg',
        username: 'zendaya',
        name: '😂😱😩',
        bio: 'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
        totalPost: 0,
        totalFollower: 0,
        totalFollowing: 0
    ),
    Users(
        image: 'assets/users/zendaya.jpg',
        username: 'zendaya',
        name: '😂😱😩',
        bio: 'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
        totalPost: 0,
        totalFollower: 0,
        totalFollowing: 0
    ),
    Users(
        image: 'assets/users/zendaya.jpg',
        username: 'zendaya',
        name: '😂😱😩',
        bio: 'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
        totalPost: 0,
        totalFollower: 0,
        totalFollowing: 0
    ),
    Users(
        image: 'assets/users/zendaya.jpg',
        username: 'zendaya',
        name: '😂😱😩',
        bio: 'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
        totalPost: 0,
        totalFollower: 0,
        totalFollowing: 0
    ),
    Users(
        image: 'assets/users/zendaya.jpg',
        username: 'zendaya',
        name: '😂😱😩',
        bio: 'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
        totalPost: 0,
        totalFollower: 0,
        totalFollowing: 0
    ),
  ];

  List<Users> getUsersList(){
    return user;
  }
}

