import 'package:flutter/material.dart';

class StatusLabel extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  const StatusLabel({
    Key? key,
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(52),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(52),
        child: Container(
          width: width,
          height: 39,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
