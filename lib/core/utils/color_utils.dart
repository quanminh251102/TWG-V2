import 'package:flutter/material.dart';

class ColorUtils {
  static Color fromString(String colorString) {
    if (colorString == null) {
      return Color(0xffF2F2F2);
    }
    try {
      // rgba(247, 247, 247, 0.73)
      if (colorString.substring(0, 4) == 'rgba') {
        String tempString = colorString;
        tempString = tempString.substring(4);
        tempString = tempString.replaceAll('(', '');
        tempString = tempString.replaceAll(')', '');
        List<String> rgbaValueList = tempString.split(',');
        rgbaValueList = rgbaValueList.map((e) => e.trim()).toList();

        if (rgbaValueList.length != 4) {
          throw Exception('Invalid string color');
        }

        try {
          int red = int.parse(rgbaValueList[0]);
          int green = int.parse(rgbaValueList[1]);
          int blue = int.parse(rgbaValueList[2]);
          double alpha = double.parse(rgbaValueList[3]);
          return Color.fromRGBO(red, green, blue, alpha);
        } catch (e) {
          throw e;
        }
      }

      // #f3e2d0
      final buffer = StringBuffer();
      if (colorString.length == 6 || colorString.length == 7)
        buffer.write('ff');
      buffer.write(colorString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Color(0xffF2F2F2);
    }
  }

  static const Color primaryColor = Color(0xffFEBB1B);
  static const Color lightPrimaryColor = Color(0xffFFF8E8);
  static const Color darkPrimaryColor = Color.fromARGB(255, 12, 62, 0);
  static Color subTileButtonColor = const Color(0xFF000000).withOpacity(0.6);
  static Color borderColor = const Color(0xFF121212).withOpacity(0.15);
  static Color activeButtonBackgroudColor =
      const Color(0xFFEA2027).withOpacity(0.1);
  static const Color white = Colors.white;
  static const Color primaryBlackColor = Color(0xFF121212);
  static const Color black60 = Color.fromRGBO(18, 18, 18, 0.6);
  static const Color disableColor = Color(0xFF979797);
  static const grey = Color(0xFFD9D9D9);
  static const greyLight = Color(0xFFF9F9F9);
  static const greyLight2 = Color(0xFFF0F0F0);
  static const black86 = Color(0xFF323232);
  static const black40 = Color(0xFF636363);
  static const black = Color(0xFF121212);
  static const red = Color(0xFFFF0009);
  static const lable = Color(0xFF323232);
  static const point = Color(0xFFDD7700);
  static const Color green = Color(0xFF06A014);
  static const Color divider = Color(0xFFEBEBEB);
  static const Color hint = Color(0xFF1A153A);
  static const Color orange86 = Color(0xDBFF3D00);
  static const Color blue = Color(0xFF0078FF);
  static const Color blueIOS = Color(0xFF0A7AFF);
  static const Color backgroundColor = Color.fromARGB(255, 240, 240, 240);
}
