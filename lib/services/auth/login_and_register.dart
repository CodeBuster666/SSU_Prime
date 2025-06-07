import 'package:flutter/material.dart';

import '../../views/login_page.dart';
import '../../views/register_page.dart';

/*

  Login and Register Page

  - This is where the user will login or register.

*/

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  // Initially, show login page
  bool ShowLoginPage = true;


  // Toggle between login and register page
  void togglePages() {
    setState(() {
      ShowLoginPage = !ShowLoginPage;
    });
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    if (ShowLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}


