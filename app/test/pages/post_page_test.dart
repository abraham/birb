import 'package:birb/models/current_user_model.dart';
import 'package:birb/models/post_mock.dart';
import 'package:birb/pages/post_page.dart';
import 'package:birb/post_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:scoped_model/scoped_model.dart';

import '../mocks/app_mock.dart';
import '../mocks/current_user_model_mock.dart';

void main() {
  ScopedModel<CurrentUserModel> app({int count}) {
    return appMock(
      child: PostPage(
        post: mockPost(),
      ),
      mock: CurrentUserModelMock(),
    );
  }

  testWidgets('Renders a post', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(app());

      expect(find.text('Post'), findsOneWidget);
      expect(find.byType(PostItem), findsOneWidget);
    });
  });
}
