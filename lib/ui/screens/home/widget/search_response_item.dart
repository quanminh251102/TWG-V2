// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:twg/core/utils/color_utils.dart';

class SearchResponseItem extends StatelessWidget {
  const SearchResponseItem({
    Key? key,
    required this.description,
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 5.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10.w,
          ),
          const Icon(
            Icons.my_location,
            color: ColorUtils.primaryColor,
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 300.w,
            child: Text(
              description.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
