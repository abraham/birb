import 'package:birb/sign_in_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders sign in', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: SignInFab(),
    ));

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
  });
}
