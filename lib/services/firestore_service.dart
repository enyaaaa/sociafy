import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sociafy/services/storage_service.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';
import '../models/user.dart';

class FireStoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  uploadPost(String caption, String location, File file, String uid,
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
          saved: []);
      firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  updateUserData(UserModel user) {
    firestore.collection('users').doc(user.uid).update({
      'image': user.image,
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'bio': user.bio,
    });
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> savePost(String postId, String uid, List saved) async {
    String res = "Some error occurred";
    try {
      if (saved.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        firestore.collection('posts').doc(postId).update({
          'saved': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        firestore.collection('posts').doc(postId).update({
          'saved': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likeComments(String postId,String commentId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        firestore
            .collection('posts')
            .doc(postId)
        .collection('comments')
        .doc(commentId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String comment, String uid,
      String username, String image) async {
    String res = "Some error occurred";
    try {
      if (comment.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        await firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'image': image,
          'username': username,
          'uid': uid,
          'comment': comment,
          'commentId': commentId,
          'likes': [],
          'timeAgo': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  updatePostData(Post post) {
    firestore.collection('posts').doc(post.postId).update({
      'image': post.image,
      'username': post.username,
      'postUrl': post.postUrl,
      'caption': post.caption,
      'location': post.location,
    });
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String email, String followId) async {
    try {
      DocumentSnapshot snap =
          await firestore.collection('users').doc(email).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([email])
        });

        await firestore.collection('users').doc(email).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([email])
        });

        await firestore.collection('users').doc(email).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> addChatRoom(chatRoom, chatRoomId) async {
    String res = "Some error occurred";
    try {
      await firestore.collection("chatRoom").doc(chatRoomId).set(chatRoom);
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  getChats(String chatRoomId) async {
    return firestore
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<String> addMessage(String chatRoomId, chatMessageData) async {
    String res = "Some error occurred";
    try {
      await firestore
          .collection("chatRoom")
          .doc(chatRoomId)
          .collection("chats")
          .add(chatMessageData);
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  getUserChats(String itIsMyName) async {
    return await firestore
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
