import 'package:flutter/material.dart';
import 'package:twg/core/utils/text_style_utils.dart';

import 'color_utils.dart';

class ThemeUtils {
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: ColorUtils.darkPrimaryColor,
      titleTextStyle:
          TextStyleUtils.titleAppBar.copyWith(color: ColorUtils.white),
      actionsIconTheme: const IconThemeData(color: ColorUtils.grey),
    ),
    dialogBackgroundColor: ColorUtils.darkPrimaryColor,
    colorScheme: const ColorScheme.dark(primary: Colors.white),
    primaryColor: ColorUtils.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Gotham',
    tabBarTheme: const TabBarTheme(
      labelColor: ColorUtils.primaryColor,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: ColorUtils.primaryColor)),
    ),
  );
  static final lightTheme = ThemeData(
    dialogBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        backgroundColor: ColorUtils.white,
        titleTextStyle:
            TextStyleUtils.titleAppBar.copyWith(color: ColorUtils.black),
        actionsIconTheme: const IconThemeData(color: ColorUtils.black)),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorUtils.primaryColor,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ColorUtils.primaryColor,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: ColorUtils.primaryColor)),
    ),
    primaryColor: ColorUtils.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Gotham',
  );
}
