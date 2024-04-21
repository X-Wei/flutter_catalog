import 'package:flutter/material.dart';

// This file is adapted from
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/gallery/themes.dart

final kLightTheme = _buildLightTheme();
final kDarkTheme = _buildDarkTheme();
const _primaryColor = Color(0xFF0175c2);
const _secondaryColor = Color(0xFF13B9FD);

ThemeData _buildLightTheme() {
  final colorScheme = const ColorScheme.light().copyWith(
    primary: _primaryColor,
    secondary: _secondaryColor,
    background: Colors.white,
    error: const Color(0xFFB00020),
  );
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    primaryColor: _primaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

ThemeData _buildDarkTheme() {
  final colorScheme = const ColorScheme.dark().copyWith(
    primary: _primaryColor,
    secondary: _secondaryColor,
    background: const Color(0xFF202124),
    error: const Color(0xFFB00020),
  );
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
    primaryColorDark: const Color(0xFF0050a0),
    primaryColorLight: _secondaryColor,
    indicatorColor: Colors.white,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
