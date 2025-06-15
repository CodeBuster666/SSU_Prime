import 'package:flutter/material.dart';

/*
  Loading
*/

// Show Loading Circle
void ShowLoading (BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (context) => const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
        child: CircularProgressIndicator(),
  ),
  ),
  );
}

// Hide Loading Circle
void HideLoading (BuildContext context) {
  Navigator.pop(context);
}