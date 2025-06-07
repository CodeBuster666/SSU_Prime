import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ssu_prime/services/auth/login_and_register.dart';

import '../../responsive/desktop_scaffold.dart';
import '../../responsive/mobile_scaffold.dart';
import '../../responsive/responsive.dart';
import '../../responsive/tablet_scaffold.dart';

/*
  Authentication Gate

    This is to check if the user of SSU-Prime is logged in or not.

    ______________________________________________________________________________________

    if user is logged in -> go to HomePage
    if user is not logged in -> go to login page or register page
*/


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return const  Responsive(
              mobileScaffold: const MobileScaffold(),
              tabletScaffold:  const TabletScaffold(),
              desktopScaffold:  const DesktopScaffold(),
            );
          }
          // User is not logged in
          else {
            return const LoginAndRegister();
          }
        },
      ),
    );
  }
}