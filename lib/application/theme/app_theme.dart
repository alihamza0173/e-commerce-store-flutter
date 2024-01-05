import 'package:flutter/material.dart';

class AppTheme {
  static final lightMode = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blue,
    ),
  );

  static final darkMode = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.blue,
    ),
  );
}
