import 'package:flutter/material.dart';
import 'package:my_mcms/service/auth/auth_service.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';

class ForgotPasswordView extends StatefulWidget {
  static const String route = '/forgot-password';
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(titleText: "Forgot Password"),
      body: Column(
        children: [
          const Text(
            "If you forgot your password,simply enter your email and we will send you a password reset email",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              autocorrect: false,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                filled: true,
              ),
            ),
          ),
          verticalSpace(10),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase()
                  .sendPasswordReset(toEmail: _emailController.text);
            },
            child: const Text("Send Reset Email"),
          ),
        ],
      ),
    );
  }
}
