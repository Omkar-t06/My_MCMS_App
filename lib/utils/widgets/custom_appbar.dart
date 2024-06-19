// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/constants/enums.dart';
import 'package:my_mcms/constants/text_style.dart';
import 'package:my_mcms/utils/message_widget/show_log_out_dialog.dart';

AppBar customAuthAppBar({required String titleText}) {
  return AppBar(
    title: Text(
      titleText,
      style: appBarTextStyle,
    ),
    backgroundColor: ColorPalette.navBarColor,
  );
}

AppBar customViewAppBar({
  required String titleText,
  required BuildContext context,
}) {
  return AppBar(
    title: Text(
      titleText,
      style: appBarTextStyle,
    ),
    actions: [
      PopupMenuButton<MenuActions>(
        iconColor: Colors.white,
        itemBuilder: (context) {
          return const [
            PopupMenuItem(
              value: MenuActions.logout,
              child: Text("Logout"),
            )
          ];
        },
        onSelected: (value) async {
          final shouldLogOut = await showLogOutDialog(context);
          if (shouldLogOut ?? false) {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          }
        },
      )
    ],
    backgroundColor: ColorPalette.navBarColor,
  );
}
