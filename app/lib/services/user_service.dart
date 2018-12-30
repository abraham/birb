import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserService {
  UserService({
    @required this.firestore,
    @required this.firebaseAuth,
  });

  UserService.instance()
      : firestore = Firestore.instance,
        firebaseAuth = FirebaseAuth.instance;

  final Firestore firestore;
  final FirebaseAuth firebaseAuth;

  Future<FirebaseUser> currentUser() {
    return firebaseAuth.currentUser();
  }

  Future<bool> createUser(String id, Map<String, String> formData) async {
    try {
      await firestore
          .collection('users')
          .document(id)
          .setData(_newUserData(formData));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> getById(String id) async {
    final DocumentSnapshot snapshot =
        await firestore.collection('users').document(id).get();
    if (snapshot.exists) {
      return User.fromDocumentSnapshot(snapshot.documentID, snapshot.data);
    } else {
      return null;
    }
  }

  Map<String, dynamic> _newUserData(Map<String, String> formData) {
    return <String, dynamic>{}
      ..addAll(formData)
      ..addAll(<String, dynamic>{
        'agreedToTermsAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
  }
}
