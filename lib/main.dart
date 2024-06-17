import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/constants/router.dart';
import 'package:my_mcms/firebase_options.dart';
import 'package:my_mcms/utils/message_widget/loader.dart';
import 'package:my_mcms/views/login_view.dart';
import 'package:my_mcms/views/registration_view.dart';
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            // print(user);
            if (user != null) {
              if (user.phoneNumber == "" && user.emailVerified == false) {
                return const VerifyEmail();
              } else {
                return const RegistrationView();
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
