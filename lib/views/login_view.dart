// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/constants/enums.dart';
import 'package:my_mcms/constants/text_style.dart';
import 'package:my_mcms/service/auth/auth_expections.dart';
import 'package:my_mcms/service/auth/auth_service.dart';
import 'package:my_mcms/utils/message_widget/show_snackbar.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';
import 'package:my_mcms/views/client_views/client_home_view.dart';
import 'package:my_mcms/views/registration_view.dart';
import 'package:my_mcms/utils/widgets/auth_textfield.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/views/verify_email.dart';

class LoginView extends StatefulWidget {
  static const String route = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      backgroundColor: ColorPalette.background,
      appBar: customAuthAppBar(titleText: "Login"),
      body: Column(
        children: [
          const Column(
            children: [
              TitleText(
                data: "Welcome To Municipal Corporation Complaint System",
              ),
              Text("Please Login to continue"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Card(
              color: ColorPalette.backgroundVariance,
              child: Column(
                children: [
                  const Text("Login Using:"),
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
                          verticalSpace(5),
                          PasswordTextField(
                            controller: _passwordController,
                          ),
                        ],
                      ),
                    TextButton(
                      onPressed: () async {
                        if (_options == RegistrationOptions.email) {
                          try {
                            await AuthService.firebase().logIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            final user = AuthService.firebase().currentUser;
                            if (user?.isEmailVerified == false) {
                              await AuthService.firebase()
                                  .sendEmailVerification();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                VerifyEmail.route,
                                (route) => false,
                              );
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                ClientHomeView.route,
                                (route) => false,
                              );
                            }
                          } on UserNotFoundException catch (_) {
                            showSnackBar(context, "User not found");
                          } on WrongPasswordException catch (_) {
                            showSnackBar(context, "Wrong Credenials");
                          } on GenericException catch (_) {
                            showSnackBar(context, "Authentication Error");
                          }
                        } else {
                          try {
                            final phoneNumber =
                                _phoneController.text.startsWith("+91")
                                    ? _phoneController.text
                                    : "+91${_phoneController.text}";
                            await AuthService.firebase().phoneSignInService(
                              context,
                              phoneNumber,
                            );
                            final user = AuthService.firebase().currentUser;
                            if (user == null) {
                              showSnackBar(
                                context,
                                "Verify with OTP and click Login again",
                              );
                            } else {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                ClientHomeView.route,
                                (_) => false,
                              );
                            }
                          } on InvalidPhoneNumberException catch (_) {
                            showSnackBar(context, "Invaid Phone Number");
                          } on NetworkRequestFailureException catch (_) {
                            showSnackBar(context, "Network Error");
                          } on GenericException catch (_) {
                            showSnackBar(context, "Authentication Error");
                          }
                        }
                      },
                      child: const Text("Log In", style: buttonTextStyle),
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
