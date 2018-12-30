import 'package:flutter/material.dart';

import '../models/post.dart';
import '../post_item.dart';

class PostPage extends StatelessWidget {
  const PostPage({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: PostItem(post),
        ),
      ),
    );
  }
}
