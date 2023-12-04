// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';

import 'package:twg/core/utils/color_utils.dart';

class BookingSearchItem extends StatelessWidget {
  const BookingSearchItem({
    Key? key,
    required this.predictions,
  }) : super(key: key);
  final Predictions predictions;

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
            width: 12.w,
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(
                5.r,
              ),
              child: const Icon(
                Icons.location_pin,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300.w,
                child: Text(
                  predictions.description!.split(',')[0].toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 320.w,
                child: Text(
                  predictions.description!
                      .split(', ')
                      .sublist(1)
                      .join(', ')
                      .toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 12.w,
          ),
          const Icon(
            Icons.bookmark_outline,
          )
        ],
      ),
    );
  }
}
