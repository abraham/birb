import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/current_user_model.dart';
import '../models/post.dart';
import '../models/post_mock.dart';
import '../posts_list.dart';
import '../sign_in_fab.dart';
import '../sign_out_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  static const String routeName = '/';
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0.0,
        actions: const <Widget>[
          SignOutAction(),
        ],
      ),
      body: PostsList(_loadPosts(context)),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _floatingActionButton() {
    return ScopedModelDescendant<CurrentUserModel>(
      builder: (
        BuildContext context,
        Widget child,
        CurrentUserModel model,
      ) =>
          model.user == null ? const SignInFab() : Container(),
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
