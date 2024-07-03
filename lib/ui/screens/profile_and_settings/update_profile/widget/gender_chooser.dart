// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:twg/core/utils/color_utils.dart';

class GenderChooser extends StatefulWidget {
  final bool isMale;
  final Function(String gender) selectGender;
  const GenderChooser({
    Key? key,
    required this.isMale,
    required this.selectGender,
  }) : super(key: key);

  @override
  State<GenderChooser> createState() => _GenderChooserState();
}

class _GenderChooserState extends State<GenderChooser> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: InkWell(
              onTap: () {
                widget.selectGender("male");
              },
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  32.r,
                ),
              ),
              child: Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: widget.isMale
                      ? ColorUtils.primaryColor
                      : Colors.grey.withOpacity(
                          0.5,
                        ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.male,
                      size: 60,
                      color: widget.isMale ? Colors.white : Colors.grey,
                    ),
                    Text(
                      'Nam',
                      style: TextStyle(
                        color: widget.isMale ? Colors.white : Colors.grey,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: InkWell(
              onTap: () {
                widget.selectGender("female");
              },
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  32.r,
                ),
              ),
              child: Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                  color: !widget.isMale
                      ? ColorUtils.primaryColor
                      : Colors.grey.withOpacity(
                          0.5,
                        ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.female,
                      size: 60,
                      color: !widget.isMale ? Colors.white : Colors.grey,
                    ),
                    Text(
                      'Nữ',
                      style: TextStyle(
                        color: !widget.isMale ? Colors.white : Colors.grey,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
