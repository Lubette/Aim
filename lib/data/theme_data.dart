import 'package:flutter/material.dart';

ThemeData themeData() => ThemeData(
      fontFamily: 'JBMN',
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.white70.withAlpha(210),
        onPrimary: Colors.black,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Colors.red.shade200,
        onError: Colors.yellow.shade200,
        surface: Colors.white,
        onSurface: Colors.black87,
      ),
    );
