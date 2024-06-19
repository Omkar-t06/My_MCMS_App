// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/constants/enums.dart';
import 'package:my_mcms/constants/text_style.dart';
import 'package:my_mcms/utils/message_widget/show_otp_dialog.dart';
import 'package:my_mcms/utils/message_widget/show_snackbar.dart';
import 'package:my_mcms/views/client_views/client_home_view.dart';
import 'package:my_mcms/views/login_view.dart';
import 'package:my_mcms/utils/widgets/auth_textfield.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/views/verify_email.dart';

class RegistrationView extends StatefulWidget {
  static const String route = '/registration';
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  RegistrationOptions _options = RegistrationOptions.phoneNo;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void switchOptions(RegistrationOptions? value) {
    setState(() {
      _options = value!;
    });
  }

  void phoneSign() async {
    try {
      await phoneSignInService(context, _phoneController.text.trim());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> phoneSignInService(BuildContext context, String phoneNo) async {
    TextEditingController codeController = TextEditingController();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        showSnackBar(
          context,
          e.message ?? 'An error occurred. Please try again later.',
        );
      },
      codeSent: ((String verificationId, int? refreshToken) {
        showOTPDialog(
          context: context,
          controller: codeController,
          onPressed: () async {
            PhoneAuthCredential credentials = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: codeController.text.trim(),
            );
            await FirebaseAuth.instance.signInWithCredential(credentials);
            Navigator.of(context).pop();
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: customAuthAppBar(titleText: "Registration"),
      body: Column(
        children: [
          const TitleText(
            data: "Welcome To Municipal Corporation Complaint System",
          ),
          const Text("Please Register Yourself"),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Card(
              color: ColorPalette.backgroundVariance,
              child: Column(
                children: [
                  const Text("Register Using:"),
                  Row(
                    children: [
                      SizedBox(
                        width: currentWidth * 0.45,
                        child: ListTile(
                          title: const Text("Phone No."),
                          leading: Radio<RegistrationOptions>(
                            value: RegistrationOptions.phoneNo,
                            groupValue: _options,
                            onChanged: switchOptions,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: currentWidth * 0.45,
                        child: ListTile(
                          title: const Text("Email"),
                          leading: Radio<RegistrationOptions>(
                            value: RegistrationOptions.email,
                            groupValue: _options,
                            onChanged: switchOptions,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: ColorPalette.backgroundVariance,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Column(
                  children: [
                    if (_options == RegistrationOptions.phoneNo)
                      IdCredencialTextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: 'Enter your phone number',
                        label: 'Phone Number',
                        icon: const Icon(Icons.phone),
                      ),
                    if (_options == RegistrationOptions.email)
                      Column(
                        children: [
                          IdCredencialTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Enter your email',
                            label: 'Email',
                            icon: const Icon(Icons.email),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          PasswordTextField(
                            controller: _passwordController,
                          ),
                        ],
                      ),
                    TextButton(
                      onPressed: () async {
                        if (_options == RegistrationOptions.email) {
                          try {
                            final userCred = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            userCred.user!.sendEmailVerification();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              VerifyEmail.route,
                              (route) => false,
                            );
                          } catch (e) {
                            showSnackBar(context, e.toString());
                          }
                        } else {
                          phoneSign();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ClientHomeView.route, (_) => false);
                        }
                      },
                      child: const Text("Register", style: buttonTextStyle),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginView.route,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Already Registered? Login Here",
                        style: buttonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
