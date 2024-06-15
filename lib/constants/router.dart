import 'package:flutter/material.dart';
import 'package:my_mcms/views/registration_view.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RegistrationView.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const RegistrationView(),
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
