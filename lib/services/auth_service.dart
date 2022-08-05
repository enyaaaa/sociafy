import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart' as model;

class AuthService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

// get user details
  Future<model.UserModel> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(currentUser.uid).get();

    return model.UserModel.fromSnap(documentSnapshot);
  }

  // Signing Up User
  Future<UserCredential> register(email, password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  //User login
  Future<UserCredential> login(email, password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> forgotPassword(email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  logout() {
    return FirebaseAuth.instance.signOut();
  }
}
