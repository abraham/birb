import 'package:birb/sign_in_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/auth_mock.dart';
import 'mocks/firebase_user_mock.dart';

void main() {
  testWidgets('Renders sign in', (WidgetTester tester) async {
    final AuthMock mock = AuthMock();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignInFab(auth: mock),
    ));

    when(mock.signInWithGoogle())
        .thenAnswer((_) => Future<FirebaseUserMock>.value(FirebaseUserMock()));

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));

    verify(mock.signInWithGoogle()).called(1);
  });
}
