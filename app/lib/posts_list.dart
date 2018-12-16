import 'package:flutter/material.dart';
import 'bad_connection.dart';
import 'models/post.dart';
import 'no_content.dart';
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
          return const BadConnection();
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.data.isEmpty) {
              return const NoContent();
            }
            return _itemList(snapshot.data);
        }
      },
    );
  }

  ListView _itemList(List<Post> items) {
    return ListView(
      children: items.map((Post post) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: PostItem(post),
        );
      }).toList(),
    );
  }
}
