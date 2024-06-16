import 'package:flutter/material.dart';
import 'package:my_mcms/constants/text_style.dart';

class TitleText extends StatelessWidget {
  final String data;
  const TitleText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: titleTextStyle,
    );
  }
}
