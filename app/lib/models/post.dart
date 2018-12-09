import 'package:flutter/foundation.dart';

class Post {
  const Post({
    @required this.id,
    @required this.username,
    @required this.createdAt,
    @required this.text,
    @required this.imageUrl,
  });

  Post.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        createdAt = DateTime.parse(data['createdAt']),
        text = data['text'],
        imageUrl = data['imageUrl'];

  final String id;
  final String username;
  final DateTime createdAt;
  final String text;
  final String imageUrl;
}
