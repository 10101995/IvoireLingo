import 'package:flutter/material.dart';

class AppTheme {
  static const Color orange = Color(0xFFFF8200);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Color(0xFF009A44);
  static const Color darkGrey = Color(0xFF333333);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: white,
      primaryColor: orange,
      colorScheme: ColorScheme.fromSeed(
        seedColor: orange,
        primary: orange,
        secondary: green,
        background: white,
        onPrimary: white,
        onSecondary: white,
        onBackground: darkGrey,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: orange,
        foregroundColor: white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: green,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: darkGrey),
        bodyLarge: TextStyle(fontFamily: 'Roboto', color: darkGrey),
      ),
    );
  }
}
