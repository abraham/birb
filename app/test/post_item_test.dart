import 'package:birb/models/post.dart';
import 'package:birb/models/post_mock.dart';
import 'package:birb/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders a post', (WidgetTester tester) async {
    final Post post = mockPost();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: PostItem(post),
    ));

    expect(find.byType(Card), findsOneWidget);
    expect(find.text(post.username), findsOneWidget);
  });
}
