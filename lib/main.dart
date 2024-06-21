import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/constants/router.dart';
import 'package:my_mcms/firebase_options.dart';
import 'package:my_mcms/service/auth/auth_service.dart';
import 'package:my_mcms/utils/message_widget/loader.dart';
import 'package:my_mcms/views/client_views/client_home_view.dart';
import 'package:my_mcms/views/login_view.dart';
import 'package:my_mcms/views/verify_email.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: ColorPalette.primary,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const ViewBuilder(),
    );
  }
}

class ViewBuilder extends StatelessWidget {
  const ViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.phoneNumber == "" && user.isEmailVerified == false) {
                return const VerifyEmail();
              } else {
                return const ClientHomeView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const Loader();
        }
      },
    );
  }
}
