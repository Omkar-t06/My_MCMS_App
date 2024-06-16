import 'package:flutter/material.dart';
import 'package:my_mcms/constants/text_style.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController controller,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("Enter OTP"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text("Done", style: buttonTextStyle),
        )
      ],
    ),
  );
}
