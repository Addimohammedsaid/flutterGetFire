import 'package:flutter/material.dart';

import './app_text.dart';
import './app_color.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: AppColors.DARK_BLUE,
  accentColor: AppColors.TEAL,
  splashColor: AppColors.TEAL,
  highlightColor: AppColors.TEAL,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: AppColors.WHITE, //Color(0xFFF3F5F7)
  inputDecorationTheme: new InputDecorationTheme(
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    labelStyle: new TextStyle(color: AppColors.DARK),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: AppColors.DARK, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: AppColors.DARK, width: 1.5),
    ),
  ),
  textTheme: TextTheme(
    headline1: AppText.TITLE,
    bodyText1: AppText.TEXT,
    bodyText2: AppText.TEXT.copyWith(fontWeight: FontWeight.bold),
  ),
);
