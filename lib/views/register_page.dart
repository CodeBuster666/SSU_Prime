import 'package:flutter/material.dart';
import 'package:ssu_prime/components/loading.dart';
import 'package:ssu_prime/services/auth/auth_service.dart';
import '../components/button.dart';
import '../components/textfield.dart';
import '../responsive/responsive.dart';
import 'login_page.dart';

/*
  Register Page

    On this page, a new user can fill out the form and create an account.
    The data we want from the user is:

    - School ID
    - Email
    - Password
    - Confirm password

    ______________________________________________________________________________________

    Once the user successfully create an account -> they will be redirected to home page.

    Also, they can go to the login page from here if they already have an accouont.

*/

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Access Authentication & Database Service
  final _auth = AuthService();


  // Text Controllers
  final TextEditingController SchoolIdController = TextEditingController();
  final TextEditingController FirstNameController = TextEditingController();
  final TextEditingController LastNameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController = TextEditingController();

  // Register button tapped
  void Register() async{
    // Password match -> create account
    if(PasswordController.text == ConfirmPasswordController.text){
      // Show Loading Circle
      ShowLoading(context);

      // Attempt to Register New User
      try{
        // Trying to Register New User
        await _auth.RegisterEmailPassword(
            EmailController.text,
            PasswordController.text);

        // After Successfully Registration, Create and Save User Profile in Database
        if (mounted) HideLoading(context);
      }

      catch (e) {
        // Inform the User of the error
        if(mounted){
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      }
    }
    // Confirm if the ID is Match to the registered Student ID of the School.

    else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match!"),
        ),
      );
    }
  }


  // Build UI
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
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

        // Body
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

              // Create Account Message
              Text(
                "Let's Sign Up!",
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              // School Text field
              MyTextfield(
                controller: SchoolIdController,
                hintText: "Enter School ID",
                obscureText: false,
              ),


              const SizedBox(height: 10),

              // Email Text field
              MyTextfield(
                controller: EmailController,
                hintText: "Enter Email",
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // Password Text field
              MyTextfield(
                controller: PasswordController,
                hintText: "Enter Password",
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // Confirm New Password Text field
              MyTextfield(
                controller: ConfirmPasswordController,
                hintText: "Confirm New Password",
                obscureText: true,
              ),

              const SizedBox(height: 20),

              // Sign In Button
              MyButton(
                text: "Register",
                onTap: Register,
              ),

              const SizedBox(height: 20),

              // Already a member? Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .hintColor,
                    ),
                  ),

                  const SizedBox(width: 4),

                  // User can tap this to go to the login page
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            LoginPage(onTap: widget.onTap),
                        ),
                      );
                    },

                    // User can tap this to go to the login page
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .hintColor,
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