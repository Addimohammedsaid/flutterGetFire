import 'package:flutter/material.dart';

class AppColors {
  // ignore: non_constant_identifier_names
  static final MaterialColor DARK_BLUE = _factoryColor(0xff0f3057);

  // ignore: non_constant_identifier_names
  static final MaterialColor TEAL = _factoryColor(0xff008891);

  // ignore: non_constant_identifier_names
  static final MaterialColor WHITE = _factoryColor(0xffe7e7de);

  // ignore: non_constant_identifier_names
  static final MaterialColor LIGHT_GREY = _factoryColor(0xffEEEEEE);

  // ignore: non_constant_identifier_names
  static final MaterialColor DARK = _factoryColor(0xff000000);

  static MaterialColor _factoryColor(int color) {
    return MaterialColor(color, <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(color),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    });
  }
}
