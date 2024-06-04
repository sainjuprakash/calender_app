import 'package:flutter/material.dart';

class ThemeHelper {
  static const primaryColor = Color(0xFF0D47A1);
  static const secondaryColor = Color(0xFF00C853);

  static ThemeData getLightTheme = ThemeData(
      colorScheme: const ColorScheme.light(
          primary: primaryColor, secondary: secondaryColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[300],
        thickness: 1,
      ));

  static ThemeData getDarkTheme = ThemeData(
      colorScheme: const ColorScheme.dark(
          primary: primaryColor, secondary: secondaryColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[300],
        thickness: 1,
      ));
}
