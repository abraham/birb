import 'package:birb/pages/home_page.dart';
import 'package:birb/posts_list.dart';
import 'package:birb/sign_in_fab.dart';
import 'package:birb/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

void main() {
  const MaterialApp app = MaterialApp(
    home: HomePage(title: 'Awesome'),
  );

  testWidgets('Renders list of posts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.text('Awesome'), findsOneWidget);
    expect(find.byType(PostsList), findsOneWidget);

    final AnnotatedRegionLayer<SystemUiOverlayStyle> layer = tester.layers
        .firstWhere((Layer layer) =>
            layer is AnnotatedRegionLayer<SystemUiOverlayStyle>);
    expect(layer.value, lightSystemUiOverlayStyle);
  });

  testWidgets('Renders sign in FAB', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.byType(SignInFab), findsOneWidget);
  });
}
