// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/constants/text_style.dart';

AppBar customAppBar({required String titleText}) {
  return AppBar(
    title: Text(
      titleText,
      style: appBarTextStyle,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: ColorPalette.navBarColor,
  );
}

// AppBar customViewAppBar({
//   required String titleText,
//   required BuildContext context,
// }) {
//   return AppBar(
//     title: Text(
//       titleText,
//       style: appBarTextStyle,
//     ),
//     iconTheme: const IconThemeData(color: Colors.white),
//     actions: [
//       PopupMenuButton<MenuActions>(
//         itemBuilder: (context) {
//           return const [
//             PopupMenuItem(
//               value: MenuActions.logout,
//               child: Text("Logout"),
//             )
//           ];
//         },
//         onSelected: (value) async {
//           final shouldLogOut = await showLogOutDialog(context);
//           if (shouldLogOut ?? false) {
//             await AuthService.firebase().logOut();
//             Navigator.of(context)
//                 .pushNamedAndRemoveUntil(LoginView.route, (route) => false);
//           }
//         },
//       )
//     ],
//     backgroundColor: ColorPalette.navBarColor,
//   );
// }
