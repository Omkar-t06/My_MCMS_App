import 'package:flutter/material.dart';
import 'package:my_mcms/views/client_views/client_home_view.dart';
import 'package:my_mcms/views/auth_screen/login_view.dart';
import 'package:my_mcms/views/auth_screen/registration_view.dart';
import 'package:my_mcms/views/auth_screen/verify_email.dart';

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
