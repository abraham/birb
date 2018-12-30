import 'package:birb/forms/register_form.dart';
import 'package:birb/models/current_user_model.dart';
import 'package:birb/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mock.dart';
import '../mocks/current_user_model_mock.dart';
import '../mocks/firebase_user_mock.dart';

void main() {
  final CurrentUserModel mock = CurrentUserModelMock();
  final FirebaseUser firebaseUserMock = FirebaseUserMock();
  when(mock.firebaseUser).thenReturn(firebaseUserMock);
  final dynamic app = appMock(
    child: const RegisterPage(),
    mock: mock,
  );

  testWidgets('Renders', (WidgetTester tester) async {
    when(mock.status).thenReturn(Status.Unregistered);
    await tester.pumpWidget(app);
    await tester.pump(Duration.zero);

    expect(find.text('Register'), findsNWidgets(2));
    expect(find.byType(RegisterForm), findsOneWidget);
  });
}
