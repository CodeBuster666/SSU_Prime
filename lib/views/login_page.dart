import 'package:flutter/material.dart';
import 'package:ssu_prime/responsive/responsive.dart';
import 'package:ssu_prime/services/auth/auth_service.dart';
import 'package:ssu_prime/views/register_page.dart';
import '../components/button.dart';
import '../components/textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Access to Auth Service
  final _auth = AuthService();

  // text Controllers
  final TextEditingController EmailControlller = TextEditingController();
  final TextEditingController PasswordControlller = TextEditingController();

  // Login Method
  void Login () async {
    // Attempt to login
    try {
      await _auth.LoginEmailPassword(
          EmailControlller.text,
          PasswordControlller.text);
    }

    // Catch any errors
    catch (e) {
      print(e.toString());
    }
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFAFAFA),
            Color(0xFFE3F2FD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor:
        Colors.transparent, // Background Color

        //Body
        body: SafeArea(
          child: Row(
            children: [

              if (Responsive.isDesktop(context))
                Expanded(
                  child: Column(),
                ),

              Expanded(
                child: buildPadding(context),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Padding buildPadding(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              // Logo
              Icon(
                Icons.school,
                size: 100,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),

              /*
                 Container(
                     width: 200,
                     height: 200,
                     decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Logo.png"),
                        fit: BoxFit.cover, // Adjust as needed
                       ),
                     ),
                   ),
              */

              const SizedBox(height: 10),

              // Welcome Back Message
              Text(
                "Welcome Back, Tradesman! ",
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              // Email Text field
              MyTextfield(
                controller: EmailControlller,
                hintText: "Enter Email",
                obscureText: false,
              ),


              const SizedBox(height: 10),

              // Password Text field
              MyTextfield(
                controller: PasswordControlller,
                hintText: "Enter Password",
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .textTheme
                        .bodySmall
                        ?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign In Button
              MyButton(
                text: "Login",
                onTap: Login,
              ),

              const SizedBox(height: 20),

              // not a member? sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .hintColor,
                    ),
                  ),

                  const SizedBox(width: 4),

                  // User can tap this to go to the signup page
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage(onTap: widget.onTap)),
                      );
                    },
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            ?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}