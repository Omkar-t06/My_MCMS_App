import 'package:flutter/widgets.dart' show BuildContext;
import 'package:my_mcms/service/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  // Email Auth Service Methods
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser?> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordReset({required String toEmail});

  // Phone No. Auth Service Methods
  Future<void> phoneSignInService(BuildContext context, String phoneNo);
}
