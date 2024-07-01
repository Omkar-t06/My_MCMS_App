// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_mcms/constants/text_style.dart';
import 'package:my_mcms/service/auth/auth_expections.dart';
import 'package:my_mcms/service/auth/auth_service.dart';
import 'package:my_mcms/utils/message_widget/show_snackbar.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/views/auth_view/login_view.dart';

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
              try {
                await AuthService.firebase().sendEmailVerification();
              } on InvalidEmailException catch (_) {
                showSnackBar(context, "Invalid Email Address");
              } on GenericException catch (_) {
                showSnackBar(context, "Error Sending Email");
              }
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
              onPressed: () async {
                await AuthService.firebase().logOut();
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
