// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/global/router.dart';

import '../../../../core/utils/color_utils.dart';

class SavePlaceBox extends StatefulWidget {
  const SavePlaceBox({super.key});

  @override
  State<SavePlaceBox> createState() => _SavePlaceBoxState();
}

class _SavePlaceBoxState extends State<SavePlaceBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Row(
            children: [
              const Icon(
                Icons.bookmark,
              ),
              SizedBox(
                width: 10.w,
              ),
              const Text(
                'ĐỊA ĐIỂM ĐÃ LƯU',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SavePlaceItem(
                    type: 0,
                    isExist: false,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SavePlaceItem(
                    type: 1,
                    isExist: false,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SavePlaceItem(
                    type: 2,
                    isExist: false,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class SavePlaceItem extends StatelessWidget {
  final int type;
  final bool isExist;
  String? placeName;
  String? placeId;
  SavePlaceItem({
    Key? key,
    required this.type,
    required this.isExist,
    this.placeName,
    this.placeId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(MyRouter.addLocation,
            arguments: EnumHelper.getEnum(
              EnumMap.savePlaceType,
              type,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              10.r,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 8.h,
          ),
          child: Row(
            children: [
              if (!isExist)
                Icon(
                  Icons.add_location,
                  color: ColorUtils.primaryColor,
                  size: 25.r,
                ),
              SizedBox(
                width: 3.w,
              ),
              !isExist
                  ? Text(
                      'Thêm ${EnumHelper.getDescription(
                        EnumMap.savePlaceType,
                        EnumHelper.getEnum(
                          EnumMap.savePlaceType,
                          type,
                        ),
                      )}',
                    )
                  : Text(
                      placeName ?? '',
                    )
            ],
          ),
        ),
      ),
    );
  }
}
