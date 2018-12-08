import 'package:birb/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders list of posts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: PostItem(),
    ));

    expect(find.byType(Card), findsOneWidget);
    expect(find.text('Prim Birb'), findsOneWidget);
  });
}
