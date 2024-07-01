import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String uid;
  final bool isEmailVerified;
  final String? email;
  final String? phoneNumber;
  const AuthUser({
    required this.uid,
    required this.isEmailVerified,
    this.email,
    this.phoneNumber,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        uid: user.uid,
        isEmailVerified: user.emailVerified,
        email: user.email ?? "",
        phoneNumber: user.phoneNumber ?? "",
      );
}
