import 'package:flutter/material.dart';

class User{
  String image;
  String username;
  String name;
  String bio;
  int totalPost;
  int totalFollower;
  int totalFollowing;
  bool isfolowedByMe;

  User ({
    required this.image,
    required this.username,
    required this.name,
    required this.bio,
    required this.totalPost,
    required this.totalFollower,
    required this.totalFollowing,
    required this.isfolowedByMe

  });
}

User currentUser = User(
  image: 'assets/users/zendaya.jpg',
  username: 'zendaya',
  name: '😂😱😩',
  bio:
      'Zendaya @euphoria @spidermanmovie @dunemovie “I’m Tired” out now @labrinth lab.lnk.to/ImTired',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);

User corbynbesson = User(
  image: 'assets/users/corbynbesson.jpg',
  username: 'corbynbesson',
  name: 'Corbyn 🛸',
  bio:
      'i’m in a band. we’re on tour this summer. “HOW DO YOU LOVE SOMEBODY” OUT NOW ❤️‍🔥',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);

User harrystyles = User(
  image: 'assets/users/harrystyles.jpg',
  username: 'harrystyles',
  name: 'Harry Styles.',
  bio: '',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);

User oliviarodrigo = User(
  image: 'assets/users/oliviarodrigo.jpg',
  username: 'oliviarodrigo',
  name: 'Olivia Rodrigo',
  bio: 'spicy pisces',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);

User seaveydaniel = User(
  image: 'assets/users/seaveydaniel.jpg',
  username: 'seaveydaniel',
  name: 'Daniel',
  bio: '@whydontwemusic',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);

User haileybieber = User(
  image: 'assets/users/haileybieber.jpg',
  username: 'haileybieber',
  name: 'Hailey Rhode Baldwin Bieber',
  bio: '@rhode',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);

User blakelively = User(
  image: 'assets/users/blakelively.jpg',
  username: 'blakelively',
  name: 'Blake Lively',
  bio: '',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);

User tomholland2013 = User(
  image: 'assets/users/tomholland2013.jpg',
  username: 'tomholland2013',
  name: 'Tom Holland',
  bio: 'Life is good @thebrotherstrust',
  totalPost: 0,
  totalFollower: 0,
  totalFollowing: 0,
  isfolowedByMe: false,
);
