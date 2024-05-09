// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/utils/color_utils.dart';

class LocationSearchItem extends StatefulWidget {
  const LocationSearchItem({
    Key? key,
    required this.placeDetail,
    required this.isSelected,
  }) : super(key: key);
  final PlaceDetailDto placeDetail;
  final bool isSelected;
  @override
  State<LocationSearchItem> createState() => _LocationSearchItemState();
}

class _LocationSearchItemState extends State<LocationSearchItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
        horizontal: 10.w,
      ),
      child: InkWell(
        child: Container(
          decoration: widget.isSelected
              ? BoxDecoration(
                  color: ColorUtils.primaryColor.withOpacity(
                    0.1,
                  ),
                  border: Border.all(
                    color: ColorUtils.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                )
              : const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
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
                        widget.placeDetail.formattedAddress!
                            .split(',')[0]
                            .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350.w,
                      child: Text(
                        widget.placeDetail.formattedAddress!
                            .split(', ')
                            .sublist(1)
                            .join(', ')
                            .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
