import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.9),
        child: Container(
          color: Colors.grey,
          height: 200,
        )
    );
  }
}
