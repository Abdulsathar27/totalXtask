import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),

    inputDecorationTheme:
        InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
      ),
    ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          55,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    ),
  );
}