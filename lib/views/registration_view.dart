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
                            await AuthService.firebase().createUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            AuthService.firebase().sendEmailVerification();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              VerifyEmail.route,
                              (route) => false,
                            );
                          } on EmailAlreadyInUseException catch (_) {
                            showSnackBar(context, "Email Already In Use");
                          } on InvalidEmailException catch (_) {
                            showSnackBar(context, "Invalid Email");
                          } on WeakPasswordException catch (_) {
                            showSnackBar(context, "Weak Password");
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
