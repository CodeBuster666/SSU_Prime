import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Color(0xFFFAFAFA), // Very Light Gray
    primary: Color(0xFF1976D2), // Medium Blue (Dodger Blue)
    tertiary: Color(0xFF4CAF50), // Medium Green
    secondary: Color(0xFFFFC107), // Amber
    error: Color(0xFFD32F2F), // Strong Red (Fire Red)
    onPrimary:  Color(0xFFFFFFFF), // White
    onSecondary: Color(0xFF000000), // Black
    onSurface: Color(0xFF212121), // Very Dark Grey
    onError: Color(0xFFFFFFFF), // White
    brightness: Brightness.light, // Light theme
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(color: Color(0xFF1A237E)), // Indigo (Dark)
    headlineMedium: TextStyle(color: Color(0xFF283593)), // Indigo (Medium)
    headlineSmall: TextStyle(color: Color(0xFF3949AB)), // Indigo (Light)
    bodyLarge: TextStyle(color: Color(0xFF333333)), // Dark Grey
    bodyMedium: TextStyle(color: Color(0xFF4F4F4F)), // Medium Grey
    bodySmall: TextStyle(color: Color(0xFF757575)), // Grey
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF1976D2), // Medium Blue (Dodger Blue)
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )
    )
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFAFAFA),// Very Light Gray
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF1976D2), // Medium Blue (Dodger Blue)
      ),
      //contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
  ),

  hintColor: const Color(0xFF9E9E9E), // Light Grey
  highlightColor: const Color(0xFF1565C0), // Sky Blue
  hoverColor: const Color(0xFF64B5F6)//0xFF1565C0),// Darker Blue
);
