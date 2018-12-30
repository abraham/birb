import 'package:flutter/material.dart';

import 'models/post.dart';
import 'no_content.dart';
import 'pages/post_page.dart';
import 'post_item.dart';

class PostsList extends StatelessWidget {
  const PostsList(this.posts);

  final Stream<List<Post>> posts;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
      stream: posts,
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading...');
          default:
            if (snapshot.data.isEmpty) {
              return const NoContent();
            }
            return _itemList(context, snapshot.data);
        }
      },
    );
  }

  ListView _itemList(BuildContext context, List<Post> items) {
    return ListView(
      children: items.map((Post post) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: InkWell(
            onTap: () => _navigateToPost(context, post),
            child: PostItem(post),
          ),
        );
      }).toList(),
    );
  }

  void _navigateToPost(BuildContext context, Post post) {
    Navigator.of(context).push(
      PageRouteBuilder<PostPage>(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return PostPage(post: post);
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
