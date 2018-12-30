import 'package:birb/forms/register_form.dart';
import 'package:birb/models/current_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scoped_model/scoped_model.dart';

import '../mocks/app_mock.dart';
import '../mocks/current_user_model_mock.dart';
import '../mocks/firebase_user_mock.dart';

void main() {
  final CurrentUserModel mock = CurrentUserModelMock();
  final FirebaseUser firebaseUserMock = FirebaseUserMock();
  when(mock.firebaseUser).thenReturn(firebaseUserMock);
  final ScopedModel<CurrentUserModel> app = appMock(
    child: const RegisterForm(),
    mock: mock,
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

    await tester.tap(submit);
    await tester.pump();

    verify(mock.register(<String, String>{
      'nickname': 'Sam',
      'fullName': 'Sam Sampson',
      'photoUrl': 'https://example.com/fake.png',
    })).called(1);
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

    verify(mock.register(<String, String>{
      'nickname': 'Jess',
      'fullName': 'Jess Jesserson',
      'photoUrl': 'https://example.com/fake.png',
    })).called(1);
  });

  testWidgets('Form requires nickname', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
    final Finder nickname = find.widgetWithText(TextFormField, 'Nickname');
    await tester.enterText(nickname, '');
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Nickname is required'), findsOneWidget);
    verifyNever(mock.register(any));
  });

  testWidgets('Form requires full name', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
    final Finder fullName = find.widgetWithText(TextFormField, 'Full name');
    await tester.enterText(fullName, '');
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Full name is required'), findsOneWidget);
    verifyNever(mock.register(any));
  });

  testWidgets('Submit disabled if TOS unchecked', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
    final Finder tos = find.byType(Checkbox);

    expect(tester.widget<OutlineButton>(submit).enabled, isTrue);

    await tester.tap(tos);
    await tester.pump();
    await tester.tap(submit);
    await tester.pump();

    expect(tester.widget<OutlineButton>(submit).enabled, isFalse);
    verifyNever(mock.register(any));
  });
}
