import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';

class ComplaintInfoView extends StatelessWidget {
  const ComplaintInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customViewAppBar(titleText: 'Complaints Info', context: context),
    );
  }
}
