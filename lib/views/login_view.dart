import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/views/registration_view.dart';
import 'package:my_mcms/widgets/auth_textfield.dart';
import 'package:my_mcms/widgets/custom_appbar.dart';
import 'package:my_mcms/widgets/title_text.dart';

class LoginView extends StatefulWidget {
  static const String route = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(titleText: "Login"),
      body: Column(
        children: [
          const Column(
            children: [
              TitleText(
                data: "Welcome To Municipal Corporation Complaint System",
              ),
              Text("Please Register Yourself"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: ColorPalette.background,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    IdCredencialTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter your email',
                      icon: const Icon(Icons.email),
                      label: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordTextField(
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RegistrationView.route,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Register Here!!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
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
