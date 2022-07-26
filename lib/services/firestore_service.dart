import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sociafy/services/storage_service.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FireStoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  uploadPost(String caption, String location, File file,
      String uid,
      String username, String image) async {

    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
      await StorageService().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
          uid: uid,
          username: username,
          image: image,
          postId: postId,
          caption: caption,
          location: location,
          timeAgo: DateTime.now(),
          postUrl: photoUrl,
          likes: [],
          saved: []

      );
      firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
