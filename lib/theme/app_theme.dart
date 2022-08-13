import 'package:Petamin/theme/colors.dart';
import 'package:flutter/material.dart';

@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
        fontFamily: 'ApercuPro',
        primaryColor: colors.green,
        primaryColorLight: const Color(0xFF3A5D66),
        primaryColorDark: const Color(0xFF000c16),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: colors.green,
            iconTheme: IconThemeData(
              color: colors.yellow,
            )),
        buttonTheme: ButtonThemeData(buttonColor: colors.green),
        textSelectionTheme: TextSelectionThemeData(cursorColor: colors.green));
  }
}
