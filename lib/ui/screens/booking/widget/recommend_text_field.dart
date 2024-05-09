// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/ilocation_viewmodel.dart';
import 'package:twg/ui/screens/booking/widget/save_place_box.dart';

import '../../../../global/router.dart';

class RecommendTextField extends StatefulWidget {
  const RecommendTextField({super.key});

  @override
  State<RecommendTextField> createState() => _RecommendTextFieldState();
}

class _RecommendTextFieldState extends State<RecommendTextField> {
  TextEditingController locationTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10.r,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => Get.toNamed(
                  MyRouter.pickLocation,
                ),
                child: CupertinoTextField(
                  enabled: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  onSubmitted: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  },
                  controller: locationTextEditingController,
                  prefix: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.orange,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.r,
                      )),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 0.w,
                  ),
                  placeholder: 'Bạn muốn đi đến đâu?',
                  placeholderStyle: locationTextEditingController.text == ''
                      ? TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        )
                      : TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Consumer<ILocationViewModel>(builder: (context, vm, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _SavePlaceItem(
                          type: 0,
                          location: vm.savedLocation.any(
                                    (element) => element.type == 'home',
                                  ) !=
                                  false
                              ? vm.savedLocation.first
                              : null),
                      SizedBox(
                        width: 5.w,
                      ),
                      _SavePlaceItem(
                        type: 1,
                        location: vm.savedLocation.any(
                                  (element) => element.type == 'company',
                                ) !=
                                false
                            ? vm.savedLocation[1]
                            : null,
                      ),
                      vm.savedLocation.length > 3
                          ? Row(
                              children: vm.savedLocation
                                  .map(
                                    (e) => Row(
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        _SavePlaceItem(
                                          type: 2,
                                          location:
                                              e.type == 'other' ? e : null,
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            )
                          : SizedBox(
                              width: 5.w,
                            ),
                      _SavePlaceItem(type: 2, location: null),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _SavePlaceItem extends StatelessWidget {
  LocationDto? location;
  int? type;
  _SavePlaceItem({
    Key? key,
    this.location,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          MyRouter.pickLocation,
          arguments: location,
        );
      },
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.grey.withOpacity(0.1),
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
              location != null
                  ? Icon(
                      location!.type == 'home'
                          ? Icons.house_outlined
                          : location!.type == 'company'
                              ? Icons.school_outlined
                              : Icons.location_pin,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.add_location,
                      color: ColorUtils.primaryColor,
                      size: 25.r,
                    ),
              SizedBox(
                width: 5.w,
              ),
              location == null
                  ? Text(
                      'Thêm ${EnumHelper.getDescription(
                        EnumMap.savePlaceType,
                        EnumHelper.getEnum(
                          EnumMap.savePlaceType,
                          type!,
                        ),
                      )}',
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location!.placeName.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            location!.placeDescription ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
