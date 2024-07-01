import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/custom_drawer.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleText: 'Profile',
      ),
      drawer: const CustomDrawer(),
    );
  }
}
