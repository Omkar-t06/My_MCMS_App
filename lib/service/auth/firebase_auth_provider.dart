// ignore_for_file: use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart'
    show BuildContext, Navigator, TextEditingController;
import 'package:my_mcms/firebase_options.dart';
import 'package:my_mcms/service/auth/auth_user.dart';
import 'package:my_mcms/service/auth/auth_provider.dart';
import 'package:my_mcms/service/auth/auth_expections.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        ConfirmationResult,
        FirebaseAuth,
        FirebaseAuthException,
        PhoneAuthCredential,
        PhoneAuthProvider;
import 'package:my_mcms/utils/message_widget/show_otp_dialog.dart';

class FirebaseAuthProvider implements AuthProvider {
  final _firebase = FirebaseAuth.instance;

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

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
      return AuthUser.fromFirebase(user);
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
      } else if (e.code == "invalid-credential") {
        throw WrongPasswordException();
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
  Future<void> sendPasswordReset({required String toEmail}) {
    try {
      return _firebase.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invail-email':
          throw InvalidEmailException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundException();
        default:
          throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<void> phoneSignInService(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      TextEditingController codeController = TextEditingController();
      if (kIsWeb) {
        ConfirmationResult res =
            await _firebase.signInWithPhoneNumber(phoneNumber);
        showOTPDialog(
          context: context,
          controller: codeController,
          onPressed: () async {
            PhoneAuthCredential credentials = PhoneAuthProvider.credential(
              verificationId: res.verificationId,
              smsCode: codeController.text.trim(),
            );
            await FirebaseAuth.instance.signInWithCredential(credentials);
            Navigator.of(context).pop();
          },
        );
      } else {
        await _firebase.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            if (e.code == "invalid-phone-number") {
              throw InvalidPhoneNumberException();
            } else if (e.code == "invaild-verification-code") {
              throw InvalidEmailException();
            } else if (e.code == "network-request-failed") {
              throw NetworkRequestFailureException();
            } else {
              throw GenericException();
            }
          },
          codeSent: ((String verificationId, int? refreshToken) {
            try {
              showOTPDialog(
                context: context,
                controller: codeController,
                onPressed: () async {
                  PhoneAuthCredential credentials =
                      PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: codeController.text.trim(),
                  );
                  await FirebaseAuth.instance.signInWithCredential(credentials);
                  Navigator.of(context).pop();
                },
              );
            } catch (e) {
              throw GenericException();
            }
          }),
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } catch (e) {
      throw GenericException();
    }
  }
}
