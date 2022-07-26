//models of user details
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String email;
  String uid;
  String image;
  String username;
  String name;
  String bio;
  List follower;
  List following;

  UserModel({
    required this.email,
    required this.uid,
    required this.image,
    required this.username,
    required this.name,
    required this.bio,
    required this.follower,
    required this.following,
  });

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      uid: snapshot['uid'],
      image: snapshot['image'],
      username: snapshot['username'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      follower: snapshot['follower'],
      following: snapshot['following'],
    );
  }

  Map<String, dynamic> toJson() => {
      "email": email,
      "uid": uid,
      "image": image,
      "username": username,
      "name": name,
      "bio": bio,
      "follower": follower,
      "following": following,
  };
}
