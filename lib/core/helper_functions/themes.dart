import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';

ThemeData LightColorTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: KlightModeBgColor,
    primaryColor: KprimaryColorLight,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: KprimaryColorLight,
      onPrimary: KprimaryColorDark,
      secondary: KprimaryColor,
      onSecondary: KsecondaryColor,
      surface: KlightModeCardColor,
      onSurface: KlightModeTextColor,
      error: KprimaryColorDark,
      onError: KsecondaryColor,
    ).copyWith(surfaceContainer: KlightModeCardColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: KprimaryColorLight,
      foregroundColor: KprimaryColorDark,
      elevation: 0,
    ),
    cardColor: KlightModeCardColor,
    dividerColor: KdisabledColor.withOpacity(0.2),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: KlightModeCardColor,
      selectedItemColor: KprimaryColor,
      unselectedItemColor: KlightModeTextSecondary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: KprimaryColor,
      foregroundColor: KlightModeCardColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: KlightModeCardColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KdisabledColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: KprimaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: const TextStyle(color: KlightModeTextSecondary),
    ),
  );
}

// ========== Dark Theme ==========
ThemeData DarkColorTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: KdarkModeBgColor,
    primaryColor: KprimaryColor,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: KprimaryColor,
      onPrimary: KlightModeCardColor,
      secondary: KprimaryColorLight,
      onSecondary: KprimaryColorDark,
      surface: KdarkModeCardColor,
      onSurface: KdarkModeTextColor,
      error: KprimaryColorDark,
      onError: KsecondaryColor,
    ).copyWith(surfaceContainer: KdarkModeCardColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: KprimaryColor,
      foregroundColor: KsecondaryColor,
      elevation: 0,
    ),
    cardColor: KdarkModeCardColor,
    dividerColor: KprimaryColorLight.withOpacity(0.2),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: KprimaryColor,
      selectedItemColor: KprimaryColorLight,
      unselectedItemColor: KdarkModeTextSecondary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: KprimaryColorLight,
      foregroundColor: KprimaryColorDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: KdarkModeCardColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KprimaryColorLight.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: KprimaryColorLight, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: const TextStyle(color: KdarkModeTextSecondary),
    ),
  );
}
