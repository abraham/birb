import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/home_page.dart';
import 'pages/register_page.dart';
import 'services/user_service.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(lightSystemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Birb',
      theme: buildThemeData(),
      home: const HomePage(title: 'Birb'),
      routes: <String, WidgetBuilder>{
        RegisterPage.routeName: (BuildContext context) => RegisterPage(
              userService: UserService(
                firebaseAuth: FirebaseAuth.instance,
                firestore: Firestore.instance,
              ),
            ),
      },
    );
  }
}
