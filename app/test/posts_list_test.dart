import 'package:birb/models/post.dart';
import 'package:birb/models/post_mock.dart';
import 'package:birb/no_content.dart';
import 'package:birb/post_item.dart';
import 'package:birb/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  group('PostsList', () {
    testWidgets('renders list of PostItems', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(MaterialApp(
          home: PostsList(mockPosts(count: 5)),
        ));

        expect(find.text('Loading...'), findsOneWidget);

        await tester.pump(Duration.zero);

        expect(find.byType(PostItem), findsNWidgets(5));
      });
    });

    testWidgets('renders NoContent widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: PostsList(mockPosts(count: 0)),
      ));
      await tester.pump(Duration.zero);

      expect(find.byType(NoContent), findsOneWidget);
    });

    testWidgets('renders error text', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: PostsList(Future<List<Post>>.error('Bad Connection').asStream()),
      ));
      await tester.pump(Duration.zero);

      expect(find.text('Error: Bad Connection'), findsOneWidget);
    });
  });
}
