import 'package:birb/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/register_page.dart';

class SignInFab extends StatelessWidget {
  const SignInFab({
    @required this.auth,
    this.existingUser = false,
  });

  final Auth auth;
  final bool existingUser;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _handleSignIn(context),
      icon: Image.asset('assets/google_g_logo.png', height: 24.0),
      label: const Text('Sign in with Google'),
    );
  }

  void _handleSignIn(BuildContext context) {
    auth.signInWithGoogle().then((FirebaseUser user) {
      if (existingUser) {
        _showSnackBar(context, 'Welcome ${user.displayName}');
      } else {
        _navigateToRegistration(context);
      }
    });
  }

  void _showSnackBar(BuildContext context, String msg) {
    final SnackBar snackBar = SnackBar(content: Text(msg));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _navigateToRegistration(BuildContext context) {
    Navigator.pushNamed(context, RegisterPage.routeName);
  }
}
