import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_utils.dart';

class ThemeUtils {
  static final darkTheme = ThemeData(
    useMaterial3: false,
    dialogBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: ColorUtils.black)),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorUtils.primaryColor,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ColorUtils.primaryColor,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: ColorUtils.primaryColor)),
    ),
    primaryColor: ColorUtils.primaryColor,
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    fontFamily: 'Gotham',
  );
  static final lightTheme = ThemeData(
    useMaterial3: false,
    dialogBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: ColorUtils.black)),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorUtils.primaryColor,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ColorUtils.primaryColor,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: ColorUtils.primaryColor)),
    ),
    primaryColor: ColorUtils.primaryColor,
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    fontFamily: 'Gotham',
  );
}
