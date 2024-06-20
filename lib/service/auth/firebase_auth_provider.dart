import 'package:my_mcms/service/auth/auth_user.dart';
import 'package:my_mcms/service/auth/auth_provider.dart';
import 'package:my_mcms/service/auth/auth_expections.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        FirebaseAuth,
        FirebaseAuthException,
        PhoneAuthCredential,
        PhoneAuthProvider;

class FirebaseAuthProvider implements AuthProvider {
  final _firebase = FirebaseAuth.instance;
  late String _verificationId;

  @override
  Future<AuthUser?> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExpection();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw WeakPasswordException();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailException();
      } else {
        throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = _firebase.currentUser;
    if (user != null) {
      return AuthUser.fromFirbase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExpection();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw UserNotFoundException();
      } else if (e.code == "wrong-password") {
        throw WrongPasswordException();
      } else {
        throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<void> logOut() {
    final user = _firebase.currentUser;
    if (user != null) {
      return _firebase.signOut();
    } else {
      throw UserNotLoggedInAuthExpection();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebase.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthExpection();
    }
  }

  @override
  Future<void> sendOtpToPhone({required String phoneNo}) async {
    try {
      await _firebase.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebase.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            throw InvalidPhoneNumberException();
          } else if (e.code == 'invalid-verification-code') {
            throw InvalidVerificationCodeException();
          } else if (e.code == 'network-request-failed') {
            throw NetworkRequestFailureException();
          } else {
            throw GenericException();
          }
        },
        codeSent: (String verificationId, int? refreshToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      throw GenericException();
    }
  }

  @override
  Future<AuthUser?> verifyOtp(
      {required String phoneNo, required String otp}) async {
    try {
      final userCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await _firebase.signInWithCredential(userCredential);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExpection();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        throw InvalidPhoneNumberException();
      } else if (e.code == 'invalid-verification-code') {
        throw InvalidVerificationCodeException();
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailureException();
      } else {
        throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }
}
