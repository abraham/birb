import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/current_user_model.dart';
import '../models/post.dart';
import '../posts_list.dart';
import '../sign_in_fab.dart';
import '../sign_out_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
    @required this.title,
    @required this.posts,
  }) : super(key: key);

  static const String routeName = '/';
  final String title;
  final Stream<List<Post>> posts;

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
      body: PostsList(widget.posts),
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
}
