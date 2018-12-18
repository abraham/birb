import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class GoogleSignInAuthenticationMock extends Mock
    implements GoogleSignInAuthentication {
  @override
  final String idToken = 'id';
  @override
  final String accessToken = 'secret';
}
