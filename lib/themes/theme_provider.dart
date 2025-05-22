import 'package:flutter/material.dart';
import 'package:ssu_prime/themes/darkmode.dart';
import 'package:ssu_prime/themes/lightmode.dart';

// Help change the app from dark to light mode.

class ThemeProvider with ChangeNotifier {

  // default, set to light mode
  ThemeData _themeData = lightMode;

  // get the current theme
  ThemeData get themeData => _themeData;

  // currently dark mode??
  bool get isDarkMode => themeData == darkMode;

  // get the theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // update UI
    notifyListeners();
  }

  // toggle between modes
  void toggleTheme() {
    if ( _themeData == lightMode ) {
      themeData = darkMode;
    }
    else {
      themeData = lightMode;
    }
    notifyListeners(); // update UI
  }
}