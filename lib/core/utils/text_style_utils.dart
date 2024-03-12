import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/utils/color_utils.dart';

class TextStyleUtils {
  static TextStyle titleAppBar = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17.sp,
  );
  static TextStyle largeHeading = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
  );
  static TextStyle title = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
  static TextStyle menu = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
  static TextStyle body = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
  );
  static TextStyle footnoteSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
  );
  static TextStyle groupTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );
  static TextStyle subHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );
  static TextStyle footNote = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );
  static TextStyle heading3 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  static TextStyle subHeadingBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
  static TextStyle subHeading2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );
  static TextStyle heading3Bold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
  );
  static TextStyle subHeading2Bold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
  );
  static TextStyle description = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10.sp,
  );
  static TextStyle footnoteBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
  );
  static TextStyle footnote2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 8.sp,
  );
  static TextStyle describeText(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? ColorUtils.describetextcolor,
      fontFamily: fontFamily ?? "NOVAFont-Regular",
    );
  }

  //Title Header
  static TextStyle titleHeader(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 18,
      color: color ?? ColorUtils.black,
      fontFamily: fontFamily ?? "NOVAFont-Bold",
    );
  }

  //Content Regular
  static TextStyle contentRegular(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? ColorUtils.black,
      fontFamily: fontFamily ?? "NOVAFont-Regular",
    );
  }

  //Content Bold
  static TextStyle contentBold(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? ColorUtils.black,
      fontFamily: fontFamily ?? "NOVAFont-Bold",
    );
  }

  //Content Black
  static TextStyle contentBlack(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? ColorUtils.black,
      fontFamily: fontFamily ?? "NOVAFont-Black",
    );
  }

  //Content Semibold
  static TextStyle contentSemibold(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? ColorUtils.black,
      fontFamily: fontFamily ?? "NOVAFont-Semibold",
    );
  }

  //Content Extrabold
  static TextStyle contentExtrabold(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? ColorUtils.black,
      fontFamily: fontFamily ?? "NOVAFont-Extrabold",
    );
  }
}
