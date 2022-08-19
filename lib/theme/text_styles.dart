import 'package:Petamin/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  static TextStyle heading1(BuildContext context, {Color? textColor}) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        color: textColor ?? AppTheme.colors.green,
        fontSize: 40,
        fontWeight: FontWeight.w500);
  }

  static TextStyle heading2(BuildContext context, {Color? textColor}) {
    return Theme.of(context)
        .textTheme
        .headline2!
        .copyWith(color: textColor ?? AppTheme.colors.green, fontSize: 32);
  }

  static TextStyle heading3(BuildContext context, {Color? textColor}) {
    return Theme.of(context)
        .textTheme
        .headline3!
        .copyWith(color: textColor ?? AppTheme.colors.green, fontSize: 24);
  }

  static TextStyle heading4(BuildContext context, {Color? textColor}) {
    return Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(color: textColor ?? AppTheme.colors.green, fontSize: 20);
  }

  static TextStyle subtitle(BuildContext context, {Color? textColor}) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
        color: textColor ?? AppTheme.colors.green,
        fontSize: 20,
        fontWeight: FontWeight.w500);
  }

  static TextStyle label(BuildContext context, {Color? textColor}) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
        color: textColor ?? AppTheme.colors.green,
        fontSize: 16,
        fontWeight: FontWeight.w500);
  }

  static TextStyle body1(BuildContext context, {Color? textColor}) {
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: textColor ?? AppTheme.colors.green, fontSize: 20);
  }

  static TextStyle body2(BuildContext context, {Color? textColor}) {
    return Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: textColor ?? AppTheme.colors.green, fontSize: 16);
  }

  static TextStyle caption(BuildContext context,
      {Color? textColor, FontWeight? fontWeight}) {
    return Theme.of(context).textTheme.caption!.copyWith(
        color: textColor ?? AppTheme.colors.green,
        fontSize: 13,
        fontWeight: fontWeight ?? FontWeight.normal);
  }
}

// textTheme: TextTheme(
      //     headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
      //     headline2: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      //     headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      //     headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      //     subtitle1: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      //     labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      //     bodyText1: TextStyle(fontSize: 20),
      //     bodyText2: TextStyle(fontSize: 16),
      //     caption: TextStyle(fontSize: 13))