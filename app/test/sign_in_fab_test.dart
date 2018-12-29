import 'package:birb/pages/register_page.dart';
import 'package:birb/services/auth.dart';
import 'package:birb/services/user_service.dart';
import 'package:birb/sign_in_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/auth_mock.dart';
import 'mocks/firebase_user_mock.dart';
import 'mocks/user_service_mock.dart';

void main() {
  final Auth mock = AuthMock();
  final FirebaseUser userMock = FirebaseUserMock();
  final UserService userServiceMock = UserServiceMock();

  MaterialApp app({bool existingUser = true}) {
    return MaterialApp(
      home: Scaffold(
        body: SignInFab(
          auth: mock,
          existingUser: existingUser,
        ),
      ),
      routes: <String, WidgetBuilder>{
        RegisterPage.routeName: (BuildContext context) =>
            RegisterPage(userService: userServiceMock),
      },
    );
  }

  testWidgets('Renders sign in', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app());

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('Calls signs in when tapped', (WidgetTester tester) async {
    when(mock.signInWithGoogle())
        .thenAnswer((_) => Future<FirebaseUser>.value(userMock));

    // Build our app and trigger a frame.
    await tester.pumpWidget(app());

    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));

    verify(mock.signInWithGoogle()).called(1);
  });

  testWidgets('Displays welcome message for existing user',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app());

    expect(find.byType(SnackBar), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(Duration.zero);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Welcome ${userMock.displayName}'), findsOneWidget);
  });

  testWidgets('Displays register form for new user',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app(existingUser: false));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(Duration.zero);
    await tester.pump(Duration.zero);

    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(RegisterPage), findsOneWidget);
  });
}
