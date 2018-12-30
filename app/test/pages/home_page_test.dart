import 'package:birb/pages/home_page.dart';
import 'package:birb/posts_list.dart';
import 'package:birb/sign_in_fab.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/app_mock.dart';
import '../mocks/current_user_model_mock.dart';

void main() {
  final dynamic app = appMock(
    child: const HomePage(title: 'Awesome'),
    mock: CurrentUserModelMock(),
  );

  testWidgets('Renders list of posts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.text('Awesome'), findsOneWidget);
    expect(find.byType(PostsList), findsOneWidget);
  });

  testWidgets('Renders sign in FAB', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.byType(SignInFab), findsOneWidget);
  });
}
