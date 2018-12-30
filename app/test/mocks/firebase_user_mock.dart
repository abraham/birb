import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class FirebaseUserMock extends Mock implements FirebaseUser {
  @override
  final String displayName = 'Sam Sampson';
  @override
  final String photoUrl = 'https://example.com/fake.png';
  @override
  final String uid = Uuid().v4();
}
