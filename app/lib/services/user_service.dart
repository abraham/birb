import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService {
  UserService({
    @required this.firestore,
    @required this.firebaseAuth,
  });

  final Firestore firestore;
  final FirebaseAuth firebaseAuth;

  Future<FirebaseUser> currentUser() {
    return firebaseAuth.currentUser();
  }

  Future<bool> addUser(String uid, Map<String, String> formData) async {
    try {
      await firestore
          .collection('users')
          .document(uid)
          .setData(_newUserData(formData));
      return true;
    } catch (e) {
      return false;
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
