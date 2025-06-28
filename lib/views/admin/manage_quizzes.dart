import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageQuizzes extends StatefulWidget {
  const ManageQuizzes({super.key});

  @override
  State<ManageQuizzes> createState() => _ManageQuizzesState();
}

class _ManageQuizzesState extends State<ManageQuizzes> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
