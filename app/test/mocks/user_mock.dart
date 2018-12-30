import 'package:birb/models/user.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class UserMock extends Mock implements User {
  @override
  final String fullName = 'Sam Sampson';
  @override
  final String nickname = 'Sam';
  @override
  final String photoUrl = 'https://example.com/fake.png';
  @override
  final String id = Uuid().v4();
}
