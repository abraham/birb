import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../forms/register_form.dart';
import '../services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key, @required this.userService}) : super(key: key);

  static const String routeName = '/register';
  final UserService userService;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseUser _firebaseUser;

  @override
  Widget build(BuildContext context) {
    _getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: _formWhenReady(),
        ),
      ),
    );
  }

  Widget _formWhenReady() {
    return _firebaseUser == null
        ? const CircularProgressIndicator()
        : RegisterForm(
            firebaseUser: _firebaseUser,
            userService: UserService(
              firestore: Firestore.instance,
              firebaseAuth: FirebaseAuth.instance,
            ),
          );
  }

  Future<void> _getCurrentUser() async {
    final FirebaseUser user = await widget.userService.currentUser();
    setState(() {
      _firebaseUser = user;
    });
  }
}
