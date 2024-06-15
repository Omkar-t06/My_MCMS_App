import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/widgets/custom_appbar.dart';

class RegistrationView extends StatelessWidget {
  static const String route = '/registration';
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppBar(titleText: "Registration"),
        backgroundColor: ColorPalette.primary,
      ),
    );
  }
}
