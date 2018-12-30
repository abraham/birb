import 'package:birb/models/current_user_model.dart';
import 'package:birb/models/user.dart';
import 'package:birb/pages/register_page.dart';
import 'package:birb/sign_in_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/app_mock.dart';
import 'mocks/current_user_model_mock.dart';
import 'mocks/firebase_user_mock.dart';
import 'mocks/user_mock.dart';

void main() {
  final CurrentUserModel mock = CurrentUserModelMock();
  final User userMock = UserMock();
  final FirebaseUser firebaseUserMock = FirebaseUserMock();

  testWidgets('Renders sign in', (WidgetTester tester) async {
    await tester.pumpWidget(appMock(
      child: const SignInFab(),
      mock: mock,
    ));

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('Calls sign in when tapped', (WidgetTester tester) async {
    when(mock.signIn()).thenAnswer((_) => Future<FirebaseUser>.value());

    await tester.pumpWidget(appMock(
      child: const SignInFab(),
      mock: mock,
    ));
    await tester.tap(find.byType(FloatingActionButton));

    verify(mock.signIn()).called(1);
  });

  testWidgets('Displays welcome message for existing user',
      (WidgetTester tester) async {
    when(mock.status).thenReturn(Status.Authenticated);
    when(mock.user).thenReturn(userMock);

    await tester.pumpWidget(appMock(
      child: const SignInFab(),
      mock: mock,
    ));

    expect(find.byType(SnackBar), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(Duration.zero);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Welcome ${userMock.fullName}'), findsOneWidget);
  });

  testWidgets('Displays registration form for new user',
      (WidgetTester tester) async {
    when(mock.status).thenReturn(Status.Unregistered);
    when(mock.user).thenReturn(userMock);
    when(mock.firebaseUser).thenReturn(firebaseUserMock);

    await tester.pumpWidget(appMock(
      child: const SignInFab(),
      mock: mock,
    ));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(Duration.zero);
    await tester.pump(Duration.zero);

    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(RegisterPage), findsOneWidget);
  });
}
