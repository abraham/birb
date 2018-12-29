import 'package:birb/forms/register_form.dart';
import 'package:birb/pages/register_page.dart';
import 'package:birb/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/user_service_mock.dart';

void main() {
  final UserService userServiceMock = UserServiceMock();
  final MaterialApp app = MaterialApp(
    home: RegisterPage(
      userService: userServiceMock,
    ),
  );

  testWidgets('Renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);
    await tester.pump(Duration.zero);

    expect(find.text('Register'), findsNWidgets(2));
    expect(find.byType(RegisterForm), findsOneWidget);
  });
}
