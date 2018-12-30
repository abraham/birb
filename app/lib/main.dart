import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/current_user_model.dart';
import 'models/post.dart';
import 'models/post_mock.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(lightSystemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CurrentUserModel>(
      model: CurrentUserModel.instance(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Birb',
        theme: buildThemeData(),
        home: HomePage(
          title: 'Birb',
          posts: _loadPosts(context),
        ),
        routes: <String, WidgetBuilder>{
          RegisterPage.routeName: (BuildContext context) =>
              const RegisterPage(),
        },
      ),
    );
  }

  Stream<List<Post>> _loadPosts(BuildContext context) {
    final List<List<dynamic>> mockSnapshot = <List<dynamic>>[
      List<dynamic>.generate(10, (int index) => mockPostData(index: index))
    ];
    return Stream<List<dynamic>>.fromIterable(mockSnapshot)
        .map(_convertToPosts);
  }

  List<Post> _convertToPosts(List<dynamic> data) {
    return data.map((dynamic item) => Post.fromMap(item)).toList();
  }
}
