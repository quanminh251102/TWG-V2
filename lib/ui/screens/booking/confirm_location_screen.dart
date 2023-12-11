import 'dart:async';
import 'dart:math' show asin, atan2, cos, log, sin, sqrt;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';
import 'package:twg/ui/screens/booking/widget/booking_search_item.dart';
import 'package:twg/ui/screens/booking/widget/place_text_field.dart';
import 'package:twg/ui/screens/booking/widget/save_place_box.dart';

class ConfirmPlaceScreen extends StatefulWidget {
  const ConfirmPlaceScreen({super.key});

  @override
  State<ConfirmPlaceScreen> createState() => _ConfirmPlaceScreenState();
}

class _ConfirmPlaceScreenState extends State<ConfirmPlaceScreen>
    with TickerProviderStateMixin {
  late final MapController mapController;
  final pinMarkers = <Marker>[];
  final placeMarkers = <Marker>[];
  LatLng? latLng;
  bool isPickFromMap = false;

  late IBookingViewModel _iBookingViewModel;

  Predictions? currentLocation;
  Predictions? currentDestination;

  bool hideSuggestLocations = false;
  bool isInit = false;
  bool isLocationFocus = true;
  bool isGetPlace = false;

  @override
  void initState() {
    mapController = MapController();

    _iBookingViewModel = context.read<IBookingViewModel>();

    Future.delayed(
      Duration.zero,
      () async {
        await _iBookingViewModel.initConfirmLocation();
      },
    );

    super.initState();
  }

  Marker buildPin(LatLng point, String description) => Marker(
        point: point,
        child: Padding(
          padding: EdgeInsets.only(left: 200.w),
          child: Row(
            children: [
              lottie.Lottie.asset(
                "assets/lottie/circle-location.json",
                repeat: true,
              ),
              SizedBox(
                width: 2.w,
              ),
              SizedBox(
                width: 260.w,
                child: Text(
                  description.split(',')[0],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
        width: 600.w,
        height: 60.h,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Địa điểm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Consumer<IBookingViewModel>(
        builder: (context, vm, child) {
          LatLng center;
          if (vm.boundConfirmScreen != null) {
            center = LatLng(
              (vm.boundConfirmScreen!.north + vm.boundConfirmScreen!.south) / 2,
              (vm.boundConfirmScreen!.east + vm.boundConfirmScreen!.west) / 2,
            );
          } else {
            center = LatLng(
              (LatLngBounds.fromPoints(
                        [
                          vm.currentLocation!,
                          vm.currentDestination!,
                        ],
                      ).north +
                      LatLngBounds.fromPoints(
                        [
                          vm.currentLocation!,
                          vm.currentDestination!,
                        ],
                      ).south) /
                  2,
              (LatLngBounds.fromPoints(
                        [
                          vm.currentLocation!,
                          vm.currentDestination!,
                        ],
                      ).east +
                      LatLngBounds.fromPoints(
                        [
                          vm.currentLocation!,
                          vm.currentDestination!,
                        ],
                      ).west) /
                  2,
            );
          }
          double zoomLevel = calculateZoomLevel(
                vm.currentLocation!.latitude,
                vm.currentLocation!.longitude,
                vm.currentDestination!.latitude,
                vm.currentDestination!.longitude,
                MediaQuery.of(context).size.width,
              ) -
              1;
          return Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCameraFit: CameraFit.bounds(
                    padding: EdgeInsets.only(
                      left: 100.w,
                      top: 50.h + MediaQuery.of(context).padding.top,
                      right: 100.w,
                      bottom: 400.h,
                    ),
                    bounds: vm.boundConfirmScreen ??
                        LatLngBounds.fromPoints(
                          [vm.currentLocation!, vm.currentDestination!],
                        ),
                  ),
                  initialCenter: center,
                  initialZoom: zoomLevel,
                  maxZoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/minhquan2511/cloeed6yc000e01qu0iukbk6l/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWluaHF1YW4yNTExIiwiYSI6ImNsaGVpNGNrbTB4ZHozZXA0NWN4NHAydWsifQ.eFaaP1FOzhDovmTSXS6Lsw',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  if (vm.currentDirection != null)
                    PolylineLayer(
                      polylineCulling: false,
                      polylines: [
                        Polyline(
                          points: vm.currentDirection!.coordinates!,
                          color: ColorUtils.primaryColor,
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: vm.currentLocation!,
                        child: lottie.Lottie.asset(
                          "assets/lottie/location.json",
                          repeat: true,
                        ),
                        width: 60.w,
                        height: 60.h,
                      ),
                      Marker(
                        point: vm.currentDestination!,
                        child: lottie.Lottie.asset(
                          "assets/lottie/location.json",
                          repeat: true,
                        ),
                        width: 60.w,
                        height: 60.h,
                      ),
                    ],
                    alignment: Alignment.topCenter,
                  ),
                  MarkerLayer(
                    markers: placeMarkers,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 20.w,
                  ),
                  height: 410.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 15.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin chuyến đi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 80.h,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: locator<GlobalData>()
                                    .currentUser!
                                    .avatarUrl
                                    .toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            60.0) //                 <--- border radius here
                                        ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => SizedBox(
                                  width: 50.w,
                                  height: 50.w,
                                  child: lottie.Lottie.asset(
                                    "assets/lottie/loading_image.json",
                                    repeat: true,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      locator<GlobalData>()
                                              .currentUser!
                                              .firstName ??
                                          "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  if (vm.currentBooking != null)
                                    Text(vm.currentBooking!.bookingType ?? "")
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/distance.svg",
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                if (vm.currentDirection != null)
                                  Text(
                                    vm.currentDirection!.distance!,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/clock.svg",
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                if (vm.currentDirection != null)
                                  Text(
                                    vm.currentDirection!.duration!,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/wallet.svg",
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                if (vm.currentDirection != null)
                                  Text(
                                    vm.currentDirection!.price!,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.person,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Điểm đi',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 300.w,
                                      child: Text(
                                        '${vm.currentBooking!.startPointMainText}, ${vm.currentBooking!.startPointAddress}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 0.w),
                              child: Divider(
                                color: Colors.grey.withOpacity(
                                  0.5,
                                ),
                                height: 5.h,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: ColorUtils.primaryColor,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        'Điểm đến',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 300.w,
                                      child: Text(
                                        '${vm.currentBooking!.endPointMainText}, ${vm.currentBooking!.endPointAddress}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              MyRouter.addBooking,
                            );
                          },
                          child: Center(
                            child: Container(
                              width: 200.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: ColorUtils.primaryColor,
                                borderRadius: BorderRadius.circular(
                                  10.r,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Xác nhận',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      )),
    );
  }
}

double calculateZoomLevel(
    double lat1, double lon1, double lat2, double lon2, double screenWidth) {
  const double earthRadius = 6371000;

  double lat1Rad = degreesToRadians(lat1);
  double lon1Rad = degreesToRadians(lon1);
  double lat2Rad = degreesToRadians(lat2);
  double lon2Rad = degreesToRadians(lon2);

  double dLat = lat2Rad - lat1Rad;
  double dLon = lon2Rad - lon1Rad;
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c;

  double zoomLevel =
      log(screenWidth * screenWidth / (distance * 2 * pi)) / log(2);

  return zoomLevel;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}
