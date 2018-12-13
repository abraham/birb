import 'package:birb/models/post.dart';
import 'package:birb/models/post_mock.dart';
import 'package:birb/no_content.dart';
import 'package:birb/post_item.dart';
import 'package:birb/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostsList', () {
    testWidgets('renders list of PostItems', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: PostsList(mockPosts(count: 5)),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(Duration.zero);

      expect(find.byType(PostItem), findsNWidgets(5));
    });

    testWidgets('renders NoContent widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: PostsList(mockPosts(count: 0)),
      ));
      await tester.pump(Duration.zero);

      expect(find.byType(NoContent), findsOneWidget);
    });

    testWidgets('renders BadConnection widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: PostsList(Future<List<Post>>.error('Bad Connection').asStream()),
      ));
      await tester.pump(Duration.zero);

      expect(find.text('Unable to reach the avary'), findsOneWidget);
    });
  });
}
