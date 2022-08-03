import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, File file, bool isPost) async {
    // creating location to our firebase storage
    Reference ref = FirebaseStorage.instance.ref().child(childName).child(auth.currentUser!.uid);
    if(isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in File format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadProfilePicture(String childName, String url, File file) async {
    String id = Uuid().v1();
    Reference ref = FirebaseStorage.instance.ref().child(childName).child(auth.currentUser!.uid);

    if (url.isNotEmpty) {
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref
        .child('images/users/userProfile_$id.jpg')
        .putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}