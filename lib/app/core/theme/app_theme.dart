import 'package:flutter/material.dart';

import './app_text.dart';
import './app_color.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: AppColors.DARK_BLUE,
  accentColor: AppColors.WHITE,
  splashColor: AppColors.TEAL,
  highlightColor: AppColors.TEAL,
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    headline1: AppText.TITLE,
    bodyText1: AppText.TEXT,
  ),
);
