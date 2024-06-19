// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';

import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/booking/widget/booking_search_item.dart';
import 'package:twg/ui/screens/booking/widget/location_text_field.dart';

import '../../../global/global_data.dart';
import '../../../global/locator.dart';

class AddLocationScreen extends StatefulWidget {
  final SavePlaceType locationType;
  const AddLocationScreen({
    Key? key,
    required this.locationType,
  }) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen>
    with TickerProviderStateMixin {
  late final MapController mapController;
  LatLng? latLng;
  bool isPickFromMap = false;

  late IBookingViewModel _iBookingViewModel;

  final FocusNode locationFocusNode = FocusNode();
  final TextEditingController locationController = TextEditingController();
  Predictions? currentLocation;

  bool hideSuggestLocations = false;
  bool isInit = false;
  bool isLocationFocus = true;
  bool isGetPlace = false;

  @override
  void initState() {
    locationFocusNode.addListener(() {
      if (locationFocusNode.hasFocus) {
        setState(() {
          hideSuggestLocations = false;
          isLocationFocus = true;
        });
      }
    });
    latLng = LatLng(locator<GlobalData>().currentPosition!.latitude,
        locator<GlobalData>().currentPosition!.longitude);
    _iBookingViewModel = context.read<IBookingViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    locationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Thêm ${EnumHelper.getDescription(EnumMap.savePlaceType, widget.locationType)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.offNamed(MyRouter.pickPlaceMap);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Center(
                child: Text(
                  'Chọn từ bản đồ',
                  style: TextStyle(
                    color: ColorUtils.primaryColor,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: 300.h,
            ),
            child: LocationTextField(
              isFocus: isLocationFocus,
              locationTextEditingController: locationController,
              locationFocusNode: locationFocusNode,
              onLocationChanged: (value) async {
                if (locationController.text.length > 2) {
                  await _iBookingViewModel.onPickPlace(value);
                }
              },
            ),
          ),
          Consumer<IBookingViewModel>(builder: (context, vm, child) {
            return Container(
              child: vm.onSearchPlace
                  ? Container(
                      height: 300.h,
                      color: Colors.white,
                      child: Center(
                        child: lottie.Lottie.asset(
                            "assets/lottie/loading_location.json",
                            repeat: true,
                            height: 300.h),
                      ),
                    )
                  : vm.listPredictions.isNotEmpty &&
                          (locationController.text != '') &&
                          (locationFocusNode.hasFocus)
                      ? Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: vm.listPredictions.map((e) {
                              return InkWell(
                                onTap: () async {
                                  locationFocusNode.unfocus();
                                  String description = e.description ?? '';
                                  locationController.text = description;
                                  currentLocation =
                                      Predictions(placeId: e.placeId);
                                  if (description.isNotEmpty) {
                                    PlaceDto? searchLocation =
                                        await _iBookingViewModel.getPlaceById(
                                            currentLocation!.placeId!);
                                    if (searchLocation != null &&
                                        searchLocation.geometry != null &&
                                        searchLocation.geometry!.location !=
                                            null) {
                                      double lat = searchLocation
                                          .geometry!.location!.lat!;
                                      double lng = searchLocation
                                          .geometry!.location!.lng!;
                                      vm.currentLocation = LatLng(lat, lng);
                                    }
                                    String placeName = EnumHelper.getValue(
                                                EnumMap.savePlaceType,
                                                widget.locationType) ==
                                            0
                                        ? 'Nhà riêng'
                                        : EnumHelper.getValue(
                                                    EnumMap.savePlaceType,
                                                    widget.locationType) ==
                                                1
                                            ? 'Trường học'
                                            : locationController.text
                                                .split(',')
                                                .sublist(1)
                                                .map((part) => part.trim())
                                                .join(', ');

                                    LocationDto locationDto = LocationDto(
                                      type: widget.locationType ==
                                              SavePlaceType.home
                                          ? 'home'
                                          : widget.locationType ==
                                                  SavePlaceType.school
                                              ? 'company'
                                              : 'other',
                                      placeId: currentLocation!.placeId,
                                      placeName: placeName,
                                      placeGeoCode:
                                          '${vm.currentLocation!.latitude},${vm.currentLocation!.longitude}',
                                      placeDescription: locationController.text,
                                    );
                                    Get.toNamed(
                                      MyRouter.locationDetail,
                                      arguments: locationDto,
                                    );
                                  }
                                },
                                child: BookingSearchItem(
                                  predictions: e,
                                ),
                              );
                            }).toList(),
                          ))
                      : const SizedBox.shrink(),
            );
          }),
        ],
      )),
    );
  }
}
