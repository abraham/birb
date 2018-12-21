import 'package:birb/services/auth.dart';
import 'package:birb/sign_in_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/auth_mock.dart';
import 'mocks/firebase_user_mock.dart';

void main() {
  final Auth mock = AuthMock();
  final FirebaseUser userMock = FirebaseUserMock();
  final MaterialApp app = MaterialApp(
    home: Scaffold(
      body: SignInFab(auth: mock),
    ),
  );

  testWidgets('Renders sign in', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('Calls signs in when tapped', (WidgetTester tester) async {
    when(mock.signInWithGoogle())
        .thenAnswer((_) => Future<FirebaseUser>.value(userMock));

    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));

    verify(mock.signInWithGoogle()).called(1);
  });

  testWidgets('Displays welcome SnackBar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.byType(SnackBar), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(Duration.zero);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Welcome ${userMock.displayName}'), findsOneWidget);
  });
}
