import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/views/login_view.dart';
import 'package:my_mcms/widgets/auth_textfield.dart';
import 'package:my_mcms/widgets/custom_appbar.dart';
import 'package:my_mcms/widgets/title_text.dart';

enum RegistrationOptions { email, phoneNo }

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

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customAppBar(titleText: "Registration"),
      body: Column(
        children: [
          const TitleText(
              data: "Welcome To Municipal Corporation Complaint System"),
          const Text("Please Register Yourself"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: ColorPalette.background,
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
                        width: currentWidth * 0.4,
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
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: ColorPalette.background,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (_options == RegistrationOptions.phoneNo)
                      IdCredencialTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.phone,
                        hintText: 'Enter your phone number',
                        label: 'Phone Number',
                        icon: const Icon(Icons.phone),
                      ),
                    if (_options == RegistrationOptions.email)
                      IdCredencialTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter your email',
                        label: 'Email',
                        icon: const Icon(Icons.email),
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
                        if (_options == RegistrationOptions.email) {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        } else {
                          try {} catch (e) {
                            SnackBar(
                              content: Text(e.toString()),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Register",
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
                          LoginView.route,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Already Registered? Login Here",
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
