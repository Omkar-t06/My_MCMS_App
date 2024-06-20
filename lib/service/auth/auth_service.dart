import 'package:my_mcms/service/auth/auth_user.dart';
import 'package:my_mcms/service/auth/auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  @override
  Future<AuthUser?> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> sendOtpToPhone({required String phoneNo}) =>
      provider.sendOtpToPhone(phoneNo: phoneNo);

  @override
  Future<AuthUser?> verifyOtp({required String phoneNo, required String otp}) =>
      provider.verifyOtp(phoneNo: phoneNo, otp: otp);
}
