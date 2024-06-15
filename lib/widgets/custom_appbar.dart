import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';

customAppBar({required String titleText}) {
  return AppBar(
    title: Text(
      titleText,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: ColorPalette.primary,
  );
}
