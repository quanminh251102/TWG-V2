// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/ichatbot_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ilocation_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/booking/widget/booking_search_item.dart';

import '../../../animation/ani_bottom_sheet.dart';

class ChatPickLocationDialog extends StatefulWidget {
  final bool isStartPlace;
  const ChatPickLocationDialog({
    Key? key,
    required this.isStartPlace,
  }) : super(key: key);

  @override
  State<ChatPickLocationDialog> createState() => _ChatPickLocationDialogState();
}

class _ChatPickLocationDialogState extends State<ChatPickLocationDialog> {
  late FocusNode locationFocusNode;
  late FocusNode destinationFocusNode;
  late TextEditingController locationTextEditingController;
  late TextEditingController destinationTextEditingController;
  late IChatbotViewModel _iChatbotViewModel;
  bool isConfirm = false;

  void checkValue() {
    if (destinationTextEditingController.text.isNotEmpty ||
        locationTextEditingController.text.isNotEmpty) {
      setState(() {
        isConfirm = true;
      });
    }
  }

  @override
  void initState() {
    locationTextEditingController = TextEditingController();
    destinationTextEditingController = TextEditingController();
    locationFocusNode = FocusNode();
    destinationFocusNode = FocusNode();
    _iChatbotViewModel = context.read<IChatbotViewModel>();
    _iChatbotViewModel.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SpringSlideTransition(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 5,
                        ),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Chọn địa điểm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 15.w,
                        ),
                        child: isConfirm
                            ? InkWell(
                                onTap: () async {
                                  PlaceDto? location;
                                  final place = widget.isStartPlace
                                      ? _iChatbotViewModel.startPlace
                                      : _iChatbotViewModel.endPlace;
                                  if (place!.placeGeoCode == null) {
                                    location = await _iChatbotViewModel
                                        .getPlaceById(place.placeId!);
                                    _iChatbotViewModel.setLocationPoint(
                                      LatLng(location!.geometry!.location!.lat!,
                                          location.geometry!.location!.lng!),
                                      widget.isStartPlace,
                                    );
                                  } else {
                                    List<String> splitCoordinates =
                                        place.placeGeoCode!.split(',');
                                    double latitude =
                                        double.parse(splitCoordinates[0]);
                                    double longitude =
                                        double.parse(splitCoordinates[1]);
                                    _iChatbotViewModel.setLocationPoint(
                                      LatLng(latitude, longitude),
                                      widget.isStartPlace,
                                    );
                                  }
                                  Get.back();
                                },
                                child: Text(
                                  'Xác nhận',
                                  style: TextStyle(
                                    color: ColorUtils.primaryColor,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 30.w,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              if (widget.isStartPlace)
                SizedBox(
                  width: 400.w,
                  child: CupertinoTextField(
                    focusNode: locationFocusNode,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    },
                    onChanged: (value) async {
                      if (value.length >= 3) {
                        await _iChatbotViewModel.onPickPlace(value);
                      }
                    },
                    controller: locationTextEditingController,
                    prefix: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: const Icon(
                        Icons.person_pin,
                        color: ColorUtils.black,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(
                            0.1,
                          ),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 0.w,
                    ),
                    placeholder: 'Điểm đi',
                    placeholderStyle: locationTextEditingController.text == ''
                        ? TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.sp,
                          ),
                  ),
                ),
              if (!widget.isStartPlace)
                SizedBox(
                  width: 400.w,
                  child: CupertinoTextField(
                    focusNode: destinationFocusNode,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    },
                    onChanged: (value) async {
                      if (value.length >= 3) {
                        await _iChatbotViewModel.onPickPlace(value);
                      }
                    },
                    controller: destinationTextEditingController,
                    prefix: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child:
                          const Icon(Icons.location_pin, color: Colors.orange),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(
                        0.1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 0.w,
                    ),
                    placeholder: 'Điểm đến',
                    placeholderStyle:
                        destinationTextEditingController.text == ''
                            ? TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              )
                            : TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.sp,
                              ),
                  ),
                ),
              Consumer<ILocationViewModel>(
                builder: (context, vm, child) {
                  bool hasType1 = vm.savedLocation
                      .any((element) => element.type == 'company');

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var savedLocation in vm.savedLocation)
                          if (savedLocation.type == 'home' ||
                              savedLocation.type == 'company' ||
                              savedLocation.type == 'other')
                            _SavePlaceItem(
                              type: savedLocation.type == 'home'
                                  ? 0
                                  : (savedLocation.type == 'company' ? 1 : 2),
                              location: savedLocation,
                              onTap: () {
                                if (widget.isStartPlace) {
                                  locationTextEditingController.text =
                                      savedLocation.placeDescription!;
                                  _iChatbotViewModel.startPlace = savedLocation;
                                } else {
                                  destinationTextEditingController.text =
                                      savedLocation.placeDescription!;
                                  _iChatbotViewModel.endPlace = savedLocation;
                                }
                                checkValue();
                              },
                            ),
                        if (!hasType1)
                          _SavePlaceItem(
                            type: 1,
                            location: null,
                            onTap: () {
                              Get.toNamed(MyRouter.addLocation,
                                  arguments: EnumHelper.getEnum(
                                      EnumMap.savePlaceType, 1));
                            },
                          ),
                        if (vm.savedLocation.length <= 3)
                          _SavePlaceItem(
                            type: 2,
                            location: null,
                            onTap: () {
                              Get.toNamed(MyRouter.addLocation,
                                  arguments: EnumHelper.getEnum(
                                      EnumMap.savePlaceType, 2));
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
              Consumer<IChatbotViewModel>(
                builder: (context, vm, child) {
                  return SizedBox(
                    height: Get.size.height * 0.5,
                    child: vm.onSearchPlace
                        ? Center(
                            child: Lottie.asset(
                                "assets/lottie/loading_location.json",
                                repeat: true,
                                height: 100.h),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: vm.listPredictions.map((e) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (locationFocusNode.hasFocus) {
                                      locationTextEditingController.text =
                                          e.description!;
                                      _iChatbotViewModel.startPlace =
                                          e.toLocationDto();
                                    } else {
                                      destinationTextEditingController.text =
                                          e.description!;
                                      _iChatbotViewModel.endPlace =
                                          e.toLocationDto();
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  });
                                  checkValue();
                                },
                                child: BookingSearchItem(predictions: e),
                              );
                            }).toList(),
                          ),
                  );
                },
              ),
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
  final Function() onTap;
  _SavePlaceItem({Key? key, this.location, this.type, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
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
                      size: 25.r,
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
