import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final Map<AppTheme, ThemeData> appThemeData = <AppTheme, ThemeData>{
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      minWidth: 50,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      body1: TextStyle(
          foreground: Paint()
            ..color = Colors.black
            ..strokeWidth = 2),
      body2: TextStyle(
          foreground: Paint()
            ..color = Colors.white
            ..strokeWidth = 1),
    ),
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    buttonTheme: const ButtonThemeData(
      minWidth: 50,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      body1: TextStyle(
          foreground: Paint()
            ..color = Colors.white
            ..strokeWidth = 2),
      body2: TextStyle(
          foreground: Paint()
            ..color = Colors.black
            ..strokeWidth = 1),
    ),
  ),
};
