import 'package:birb/models/post.dart';
import 'package:birb/models/post_mock.dart';
import 'package:birb/no_content.dart';
import 'package:birb/post_item.dart';
import 'package:birb/posts_list.dart';
import 'package:birb/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:birb/models/current_user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'mocks/app_mock.dart';
import 'mocks/current_user_model_mock.dart';

void main() {
  ScopedModel<CurrentUserModel> app({int count}) {
    return appMock(
      child: PostsList(mockPosts(count: count)),
      mock: CurrentUserModelMock(),
    );
  }

  group('PostsList', () {
    testWidgets('renders list of PostItems', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(app(count: 5));

        expect(find.text('Loading...'), findsOneWidget);

        await tester.pumpAndSettle();

        expect(find.byType(PostItem), findsNWidgets(5));
      });
    });

    testWidgets('Opens post page when item is tapped',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        // TODO(abraham): get the post ID and check for Hero tag before/after
        await tester.pumpWidget(app(count: 5));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(PostItem).first);
        await tester.pumpAndSettle();

        expect(find.byType(PostPage), findsOneWidget);
      });
    });

    testWidgets('renders NoContent widget', (WidgetTester tester) async {
      await tester.pumpWidget(app(count: 0));
      await tester.pumpAndSettle();

      expect(find.byType(NoContent), findsOneWidget);
    });

    testWidgets('renders error text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: PostsList(
          Future<List<Post>>.error('Bad Connection').asStream(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Error: Bad Connection'), findsOneWidget);
    });
  });
}
