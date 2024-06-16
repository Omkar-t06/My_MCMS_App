import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String data;
  const TitleText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
