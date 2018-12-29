import 'package:birb/forms/register_form.dart';
import 'package:birb/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/firebase_user_mock.dart';
import '../mocks/user_service_mock.dart';

void main() {
  final FirebaseUser userMock = FirebaseUserMock();
  final UserService userServiceMock = UserServiceMock();
  final MaterialApp app = MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: RegisterForm(
          firebaseUser: userMock,
          userService: userServiceMock,
        ),
      ),
    ),
  );

  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('Register'), findsOneWidget);
    expect(find.text('I agree to the Terms of Services and Privacy Policy'),
        findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(OutlineButton), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('Form can be submitted with prefilled names',
      (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');

    expect(find.byType(SnackBar), findsNothing);

    await tester.tap(submit);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Welcome ${userMock.displayName}'), findsOneWidget);
  });

  testWidgets('Form can be submitted with new names',
      (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder nickname = find.widgetWithText(TextFormField, 'Nickname');
    final Finder fullName = find.widgetWithText(TextFormField, 'Full name');
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');

    expect(find.text('Form submitted'), findsNothing);

    await tester.enterText(nickname, 'Jess');
    await tester.enterText(fullName, 'Jess Jesserson');

    await tester.tap(submit);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Welcome Jess Jesserson'), findsOneWidget);
  });

  testWidgets('Form requires nickname', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
    final Finder nickname = find.widgetWithText(TextFormField, 'Nickname');
    await tester.enterText(nickname, '');
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Nickname is required'), findsOneWidget);
    expect(find.text('Form submitted'), findsNothing);
  });

  testWidgets('Form requires full name', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
    final Finder fullName = find.widgetWithText(TextFormField, 'Full name');
    await tester.enterText(fullName, '');
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Full name is required'), findsOneWidget);
    expect(find.text('Form submitted'), findsNothing);
  });

  testWidgets('Submit disabled if TOS unchecked', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
    final Finder tos = find.byType(Checkbox);

    expect(tester.widget<OutlineButton>(submit).enabled, isTrue);

    await tester.tap(tos);
    await tester.tap(submit);
    await tester.pump();

    expect(tester.widget<OutlineButton>(submit).enabled, isFalse);
    expect(find.text('Form submitted'), findsNothing);
  });
}
