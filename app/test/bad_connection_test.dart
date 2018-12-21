import 'package:birb/bad_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders content', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: BadConnection(),
    ));

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(
        find.text('Bad Connection: Unable to reach the avary'), findsOneWidget);
  });
}
