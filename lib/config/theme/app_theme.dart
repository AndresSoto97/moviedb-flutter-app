import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkTheme;

  AppTheme({this.isDarkTheme = false});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed:
            isDarkTheme ? const Color(0xFF00D8F0) : const Color(0xFF2862F5),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      );
}
