import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/utils/color_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    this.textStyle,
    this.onTap,
    this.bgColor,
    this.borderRadius,
    this.border,
  });

  final double height;
  final double width;
  final String text;
  final TextStyle? textStyle;
  final Color? bgColor;
  final double? borderRadius;
  final BoxBorder? border;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.primaryColor,
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius ?? 8.r,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(
                borderRadius ?? 8.r,
              ),
            ),
            border: border,
          ),
          alignment: Alignment.center,
          child: Center(
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
