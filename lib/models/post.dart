import 'package:cloud_firestore/cloud_firestore.dart';

//models for other users post
class Post {
  final String uid;
  final String username;
  final String image;
  final String postId;
  final String caption;
  final String location;
  final DateTime timeAgo;
  final String postUrl;
  final likes;
  final saved;

  Post({
    required this.uid,
    required this.username,
    required this.image,
    required this.postId,
    required this.caption,
    required this.location,
    required this.timeAgo,
    required this.postUrl,
    required this.likes,
    required this.saved,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      image: snapshot['image'],
      postId: snapshot['postId'],
      caption: snapshot['caption'],
      location: snapshot['location'],
      timeAgo: snapshot['timeAgo'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
      saved: snapshot['saved'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "image": image,
        "postId": postId,
        "caption": caption,
        "location": location,
        "timeAgo": timeAgo,
        "postUrl": postUrl,
        "likes": likes,
        "saved": saved,
      };
}
