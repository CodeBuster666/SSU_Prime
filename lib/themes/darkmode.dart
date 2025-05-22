import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF121212), // Near Black
      primary:  Color(0xFF90CAF9), // Light Blue
      secondary: Color(0xFFFFD54F), // Light Amber
      tertiary: Color(0xFF81C784),// Soft Green
      error: Color(0xFFEF5350), // Soft Red
      onPrimary: Color(0xFF000000), // Black
      onSecondary: Color(0xFF000000), // Black
      onSurface: Color(0xFFFFFFFF), // White
      onError: Color(0xFFFFFFFF), // Black
      brightness: Brightness.dark, // Dark theme
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Color(0xFFBBDEFB)), // Pale Blue
      headlineMedium: TextStyle(color: Color(0xFF90CAF9)), // Light Blue
      headlineSmall: TextStyle(color: Color(0xFF64B5F6)), // Sky Blue
      bodyLarge: TextStyle(color: Color(0xFFE0E0E0)),// Light Gray
      bodyMedium: TextStyle(color: Color(0xFFBDBDBD)), // Medium Gray
      bodySmall: TextStyle(color: Color(0xFF9E9E9E)), // Gray
    ),

    hintColor: const Color(0xFFB0BEC5), // Blue Gray (Muted)
    highlightColor: const Color(0xFF42A5F5), // Vivid Sky Blue
    hoverColor: const Color(0xFF64B5F6) // Sky Blue
);
