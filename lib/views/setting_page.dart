import 'package:flutter/material.dart';
import '../components/drawer.dart';


/*
  Setting Page

  - Dark Mode
  - Account Settings
  - Privacy Policy

*/

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  // Build UI
  @override
  Widget build(BuildContext context) {

    // Scaffold
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // App Bar
      appBar: myAppBar,

      // Body
      body: Column(
      ),
    );
  }
}
