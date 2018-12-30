import 'package:birb/models/current_user_model.dart';
import 'package:birb/models/post_mock.dart';
import 'package:birb/pages/home_page.dart';
import 'package:birb/posts_list.dart';
import 'package:birb/sign_in_fab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';

import '../mocks/app_mock.dart';
import '../mocks/current_user_model_mock.dart';

void main() {
  ScopedModel<CurrentUserModel> app({int count}) {
    return appMock(
      child: HomePage(
        title: 'Awesome',
        posts: mockPosts(count: 5),
      ),
      mock: CurrentUserModelMock(),
    );
  }

  testWidgets('Renders list of posts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app());

    expect(find.text('Awesome'), findsOneWidget);
    expect(find.byType(PostsList), findsOneWidget);
  });

  testWidgets('Renders sign in FAB', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app());

    expect(find.byType(SignInFab), findsOneWidget);
  });
}
