import 'package:birb/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MaterialApp app = MaterialApp(
    home: RegisterPage(),
  );

  testWidgets('Renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.text('Register'), findsNWidgets(2));
  });
}
