import 'package:flutter/material.dart';
import 'package:my_mcms/views/auth_view/forgot_password_view.dart';
import 'package:my_mcms/views/client_views/client_home_view.dart';
import 'package:my_mcms/views/auth_view/login_view.dart';
import 'package:my_mcms/views/auth_view/registration_view.dart';
import 'package:my_mcms/views/auth_view/verify_email.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RegistrationView.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const RegistrationView(),
      );
    case LoginView.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const LoginView(),
      );
    case VerifyEmail.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const VerifyEmail(),
      );
    case ClientHomeView.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const ClientHomeView(),
      );
    case ForgotPasswordView.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const ForgotPasswordView(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen Not Found"),
          ),
        ),
      );
  }
}
