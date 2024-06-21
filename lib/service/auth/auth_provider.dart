import 'package:my_mcms/service/auth/auth_user.dart';

abstract class AuthProvider {
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
  Future<void> sendOtpToPhone({required String phoneNo});

  Future<AuthUser?> verifyOtp({
    required String phoneNo,
    required String otp,
  });
}
