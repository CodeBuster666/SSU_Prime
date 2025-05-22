import 'package:flutter/material.dart';

/*
  Text Field

  A box where the user can type into.

  __________________________________________________________________________
  Instruction:
    To use this widget, you need:

    - text controller ( to access what the user has typed in )
    - hint text ( e.g. "Enter Password" )
    - obscure text ( e.g. true -> hides.password ****** )

 */

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,

  });

  // Build UI
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:  controller,
      obscureText: obscureText,
      cursorColor: Theme.of(context).highlightColor,
      decoration:  InputDecoration(

        // Border when unselected
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).highlightColor),
          borderRadius: BorderRadius.circular(11),
        ),

        // Border when selected
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor),
          borderRadius: BorderRadius.circular(11),
        ),

        fillColor: Theme.of(context).colorScheme.onPrimary, // Background color
        filled: true,
        hoverColor: Colors.transparent,

        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }
}
