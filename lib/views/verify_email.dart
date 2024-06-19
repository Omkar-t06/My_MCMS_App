import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/text_style.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/views/login_view.dart';

class VerifyEmail extends StatefulWidget {
  static const String route = '/verify-email';
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAuthAppBar(titleText: "Verify Email"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TitleText(
            data:
                "We've sent a verification email please check it and verify yourself",
          ),
          const Text(
            "If you haven't received a verification email click below",
            style: messageTextStyle,
          ),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text(
              "Send Verification Email",
              style: buttonTextStyle,
            ),
          ),
          const Text(
            "Once you verify yourself please Login here:-",
            style: messageTextStyle,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginView.route,
                  (_) => false,
                );
              },
              child: const Text(
                "Restart",
                style: buttonTextStyle,
              ))
        ],
      ),
    );
  }
}
