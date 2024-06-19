import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';

class ClientHomeView extends StatelessWidget {
  static const String route = '/client-home';
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customViewAppBar(
        titleText: 'Home Page',
        context: context,
      ),
      body: const Center(
        child: Text('Client Home Page'),
      ),
    );
  }
}
