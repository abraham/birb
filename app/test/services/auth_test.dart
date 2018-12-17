import 'package:birb/services/auth.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/firebase_auth_mock.dart';
import '../mocks/firebase_user_mock.dart';
import '../mocks/google_sign_in_account_mock.dart';
import '../mocks/google_sign_in_authentication_mock.dart';
import '../mocks/google_sign_in_mock.dart';

void main() {
  group('Auth', () {
    final FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
    final GoogleSignInMock googleSignInMock = GoogleSignInMock();
    final FirebaseUserMock firebaseUserMock = FirebaseUserMock();
    final GoogleSignInAccountMock googleSignInAccountMock =
        GoogleSignInAccountMock();
    final GoogleSignInAuthenticationMock googleSignInAuthenticationMock =
        GoogleSignInAuthenticationMock();
    final Auth auth = Auth(
      firebaseAuth: firebaseAuthMock,
      googleSignIn: googleSignInMock,
    );

    test('signInWithGoogle returns a user', () async {
      when(googleSignInMock.signIn()).thenAnswer((_) =>
          Future<GoogleSignInAccountMock>.value(googleSignInAccountMock));

      when(googleSignInAccountMock.authentication).thenAnswer((_) =>
          Future<GoogleSignInAuthenticationMock>.value(
              googleSignInAuthenticationMock));

      when(firebaseAuthMock.signInWithGoogle(
        idToken: googleSignInAuthenticationMock.idToken,
        accessToken: googleSignInAuthenticationMock.accessToken,
      )).thenAnswer((_) => Future<FirebaseUserMock>.value(firebaseUserMock));

      expect(await auth.signInWithGoogle(), firebaseUserMock);

      verify(googleSignInMock.signIn()).called(1);
      verify(googleSignInAccountMock.authentication).called(1);
      verify(firebaseAuthMock.signInWithGoogle(
        idToken: googleSignInAuthenticationMock.idToken,
        accessToken: googleSignInAuthenticationMock.accessToken,
      )).called(1);
    });
  });
}
