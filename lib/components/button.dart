import 'package:flutter/material.dart';

/*
  Button

    A simple button

  __________________________________________________________________________
  Instruction:
    To use this widget, you need this following:

    - text
    - a function (on tap)

*/

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  // Build UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Padding insider
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          // Color of the button
          color: Theme.of(context).colorScheme.primary,

          // Curved corners
          borderRadius: BorderRadius.circular(12),

        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
