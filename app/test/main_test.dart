import 'package:birb/main.dart';
import 'package:birb/posts_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders content', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('Birb'), findsOneWidget);
    expect(find.byType(PostsList), findsOneWidget);
  });
}
