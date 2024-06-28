import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customViewAppBar(titleText: 'Profile', context: context),
    );
  }
}
