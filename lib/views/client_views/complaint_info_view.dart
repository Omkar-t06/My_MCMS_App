import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/custom_drawer.dart';

class ComplaintInfoView extends StatelessWidget {
  const ComplaintInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleText: 'Complaints Info',
      ),
      drawer: const CustomDrawer(),
    );
  }
}
