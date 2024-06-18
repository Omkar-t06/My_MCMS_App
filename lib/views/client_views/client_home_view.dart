import 'package:flutter/material.dart';

class ClientHomeView extends StatelessWidget {
  static const String route = '/client-home';
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Client Home Page'),
      ),
    );
  }
}
