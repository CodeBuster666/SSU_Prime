import 'package:flutter/material.dart';

class Marg extends StatelessWidget {
    const Marg ({super.key});

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSU huhu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const ReviewModulesPage(),
    );
  }

  
}
