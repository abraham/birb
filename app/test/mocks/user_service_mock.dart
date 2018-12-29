import 'package:birb/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

import 'firebase_user_mock.dart';

class UserServiceMock extends Mock implements UserService {
  UserServiceMock({this.success = true});

  bool success;

  @override
  Future<bool> addUser(String uid, Map<String, String> formData) async {
    return success;
  }

  @override
  Future<FirebaseUser> currentUser() async {
    return FirebaseUserMock();
  }
}
