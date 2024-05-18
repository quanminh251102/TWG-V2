// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';

import '../../../global/global_data.dart';
import '../../../global/locator.dart';

class LocationDetailScreen extends StatefulWidget {
  final LocationDto location;
  const LocationDetailScreen({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen>
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
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

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
    nameController.text = widget.location.placeName ?? '';
    addressController.text = widget.location.placeDescription ?? '';
    userNameController.text =
        locator<GlobalData>().currentUser!.firstName ?? '';
    phoneNumberController.text =
        locator<GlobalData>().currentUser!.phoneNumber ?? '';
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
        title: const Text(
          'Chi tiết địa chỉ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  bottom: 5.h,
                ),
                child: Row(
                  children: [
                    Text(
                      'Tên',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: CupertinoTextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    },
                    onChanged: (value) {},
                    controller: nameController,
                    maxLines: 1,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.r,
                        )),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 10.w,
                    ),
                    placeholder: 'Tên địa chỉ',
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 5.h,
                ),
                child: Row(
                  children: [
                    Text(
                      'Địa chỉ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: CupertinoTextField(
                    enabled: false,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    },
                    onChanged: (value) {},
                    controller: addressController,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.r,
                        )),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 10.w,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 5.h,
                ),
                child: Row(
                  children: [
                    Text(
                      'Tên người liên hệ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: CupertinoTextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    },
                    onChanged: (value) {},
                    controller: userNameController,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.r,
                        )),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 10.w,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 5.h,
                ),
                child: Row(
                  children: [
                    Text(
                      'Số điện thoại',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: CupertinoTextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    },
                    onChanged: (value) {},
                    controller: phoneNumberController,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.r,
                        )),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 10.w,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  child: CustomButton(
                    height: 50.h,
                    width: 300.w,
                    text: 'Lưu',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    onTap: () async {
                      LocationDto locationDto = LocationDto(
                        type: widget.location.type,
                        placeName: nameController.text,
                        placeId: widget.location.placeId,
                        placeGeoCode: widget.location.placeGeoCode,
                        placeDescription: widget.location.placeDescription,
                      );
                      await _iBookingViewModel.saveLocation(locationDto);
                      Get.toNamed(
                        MyRouter.booking,
                        arguments: false,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
