import 'dart:convert';
import 'dart:io';

import 'package:birb/models/post.dart';
import 'package:test/test.dart';

void main() {
  group('Post', () {
    test('fromMap', () async {
      final Post post = Post.fromMap(await _postData());

      expect(post.id, '7d3d8bd1-b9a6-4e1f-8e4e-dca6f4861441');
      expect(post.username, 'woodstock');
      expect(post.imageUrl, 'https://source.unsplash.com/AEVAMhago-s');
      expect(post.createdAt, DateTime.parse('2018-12-09T15:35:54.006Z'));
      expect(post.text, '');
    });
  });
}

dynamic _postData() async {
  final dynamic data = await File('../assets/posts.json').readAsString();
  return json.decode(data).first;
}
