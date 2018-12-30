import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.agreedToTermsAt,
    @required this.createdAt,
    @required this.fullName,
    @required this.id,
    @required this.photoUrl,
    @required this.nickname,
    @required this.updatedAt,
  });

  User.fromDocumentSnapshot(this.id, Map<String, dynamic> data)
      : agreedToTermsAt = data['agreedToTermsAt'],
        createdAt = data['createdAt'],
        fullName = data['fullName'],
        photoUrl = data['photoUrl'],
        updatedAt = data['updatedAt'],
        nickname = data['nickname'];

  final DateTime agreedToTermsAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fullName;
  final String id;
  final String photoUrl;
  final String nickname;
}
