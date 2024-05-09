// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as location;
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';

import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ilocation_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/booking/pick_place_screen.dart';
import 'package:twg/ui/screens/booking/widget/booking_search_item.dart';
import 'package:twg/ui/screens/home/widget/zoom_button.dart';
import 'package:twg/ui/screens/location/widget/recommend_text_field.dart';

class ChooseFromMapScreen extends StatefulWidget {
  final bool isLocation;
  const ChooseFromMapScreen({
    Key? key,
    required this.isLocation,
  }) : super(key: key);

  @override
  State<ChooseFromMapScreen> createState() => _ChooseFromMapScreenState();
}

class _ChooseFromMapScreenState extends State<ChooseFromMapScreen>
    with TickerProviderStateMixin {
  late IBookingViewModel _iBookingViewModel;

  LatLng? latLng;
  final pinMarkers = <Marker>[];
  final placeMarkers = <Marker>[];
  final location.Location _location = location.Location();
  late MapController mapController;

  final FocusNode locationFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  Predictions? currentLocation;
  Predictions? currentDestination;

  LatLng? startPointGeo;
  LatLng? endPointGeo;

  final TextEditingController locationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  late Stream<location.LocationData> _locationStream;
  Debouncer debouncer = Debouncer(
    milliseconds: 1500,
  );

  Marker buildPin(LatLng point, String description) => Marker(
        point: point,
        child: Row(
          children: [
            lottie.Lottie.asset(
              "assets/lottie/circle-location.json",
              repeat: true,
            ),
            // SizedBox(
            //   width: 2.w,
            // ),
            // SizedBox(
            //   width: 260.w,
            //   child: Text(
            //     description.split(',')[0],
            //     overflow: TextOverflow.ellipsis,
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 14.sp,
            //     ),
            //     maxLines: 1,
            //   ),
            // )
          ],
        ),
        width: 40.w,
        height: 40.h,
      );

  Future<void> setValuePlaceField() async {
    debouncer.run(() async {
      List<PlaceDetailDto>? placeDetailDto =
          await _iBookingViewModel.getPlaceByGeocode(
        LatLng(
          locator<GlobalData>().currentPosition!.latitude,
          locator<GlobalData>().currentPosition!.longitude,
        ),
      );
      setState(() {
        startPointGeo = LatLng(
          locator<GlobalData>().currentPosition!.latitude,
          locator<GlobalData>().currentPosition!.longitude,
        );
        locationController.text =
            placeDetailDto![0].formattedAddress!.toString();
        locationController.selection = TextSelection.fromPosition(
          const TextPosition(offset: 0),
        );
      });
    });
  }

  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    mapController = MapController();

    _locationStream = _location.onLocationChanged;
    locationFocusNode.requestFocus();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pinMarkers.add(Marker(
        point: LatLng(
          locator<GlobalData>().currentPosition!.latitude,
          locator<GlobalData>().currentPosition!.longitude,
        ),
        child: lottie.Lottie.asset(
          "assets/lottie/location.json",
          repeat: true,
        ),
        width: 60.w,
        height: 60.h,
      ));
      setState(() {});
    });

    Future.delayed(
      Duration.zero,
      () async {
        await setValuePlaceField();
      },
    );
    super.initState();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    if (!pinMarkers.any((element) => element.point == destLocation)) {
      pinMarkers.add(Marker(
        point: destLocation,
        child: lottie.Lottie.asset(
          "assets/lottie/location.json",
          repeat: true,
        ),
        width: 60.w,
        height: 60.h,
      ));
    }
    setState(() {});
    controller.forward();
  }

  void updatePoint(BuildContext context) async {
    latLng = mapController.camera.center;
    setValuePlaceField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight / 2,
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    onPositionChanged: (_, __) => updatePoint(context),
                    onPointerHover: (event, point) {
                      // setState(() {
                      //   if (isInit) {
                      //     hideSuggestLocations = true;
                      //   }
                      // });
                    },
                    initialCenter: LatLng(
                      locator<GlobalData>().currentPosition!.latitude,
                      locator<GlobalData>().currentPosition!.longitude,
                    ),
                    initialZoom: 20,
                    cameraConstraint: CameraConstraint.contain(
                      bounds: LatLngBounds(
                        const LatLng(-90, -180),
                        const LatLng(90, 180),
                      ),
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/minhquan2511/cloeed6yc000e01qu0iukbk6l/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWluaHF1YW4yNTExIiwiYSI6ImNsaGVpNGNrbTB4ZHozZXA0NWN4NHAydWsifQ.eFaaP1FOzhDovmTSXS6Lsw',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(
                      markers: pinMarkers,
                      alignment: Alignment.topCenter,
                    ),
                    MarkerLayer(
                      markers: placeMarkers,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 10.w),
                      child: ZoomButtons(
                        alignment: Alignment.bottomRight,
                        zoomInColor: ColorUtils.white,
                        zoomOutColor: ColorUtils.white,
                        zoomInColorIcon: ColorUtils.primaryColor,
                        zoomOutColorIcon: ColorUtils.primaryColor,
                        myLocationColor: ColorUtils.white,
                        myLocationColorIcon: ColorUtils.primaryColor,
                        onPressed: () {
                          _animatedMapMove(
                            LatLng(
                              locator<GlobalData>().currentPosition!.latitude,
                              locator<GlobalData>().currentPosition!.longitude,
                            ),
                            19,
                          );
                        },
                      ),
                    ),
                    CurrentLocationLayer(
                      positionStream: _locationStream
                          .map((locationData) => LocationMarkerPosition(
                                latitude: locationData.latitude!,
                                longitude: locationData.longitude!,
                                accuracy: locationData.accuracy!,
                              )),
                      style: LocationMarkerStyle(
                        marker: const DefaultLocationMarker(
                          color: ColorUtils.primaryColor,
                        ),
                        markerSize: const Size.square(
                          20,
                        ),
                        accuracyCircleColor:
                            ColorUtils.primaryColor.withOpacity(
                          0.3,
                        ),
                        showAccuracyCircle: true,
                        headingSectorRadius: 120,
                      ),
                      moveAnimationDuration: Duration.zero, // disable animation
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.h,
              horizontal: 10.w,
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.96,
              minChildSize: 0.5,
              maxChildSize: 1,
              snapSizes: const [0.5, 1],
              builder: (BuildContext context, scrollSheetController) {
                return SingleChildScrollView(
                  controller: scrollSheetController,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                              ),
                              child: SizedBox(
                                width: 20.w,
                                child: InkWell(
                                  onTap: () => Get.back(),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              locationFocusNode.hasFocus
                                  ? 'Điểm đón'
                                  : 'Điểm đến',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxHeight: 300.h,
                          ),
                          child: RecommendLocationTextField(
                            isFocus: locationFocusNode.hasFocus,
                            locationTextEditingController: locationController,
                            destinationTextEditingController:
                                destinationController,
                            locationFocusNode: locationFocusNode,
                            destinationFocusNode: destinationFocusNode,
                            onLocationChanged: (value) async {
                              await _iBookingViewModel.onPickPlace(value);
                            },
                            onDestinationChanged: (value) async {
                              await _iBookingViewModel.onPickPlace(value);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Consumer<ILocationViewModel>(
                            builder: (context, vm, child) {
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
                                      : null,
                                  onTap: () {
                                    if (locationFocusNode.hasFocus ||
                                        locationController.text == '') {
                                      if (vm.savedLocation.any(
                                            (element) => element.type == 'home',
                                          ) !=
                                          false) {
                                        locationController.text = vm
                                            .savedLocation
                                            .first
                                            .placeDescription!;
                                      }
                                    } else {
                                      if (vm.savedLocation.any(
                                            (element) => element.type == 'home',
                                          ) !=
                                          false) {
                                        destinationController.text = vm
                                            .savedLocation
                                            .first
                                            .placeDescription!;
                                      }
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                _SavePlaceItem(
                                  type: 1,
                                  location: vm.savedLocation.any(
                                            (element) =>
                                                element.type == 'company',
                                          ) !=
                                          false
                                      ? vm.savedLocation[1]
                                      : null,
                                  onTap: () {
                                    if (locationFocusNode.hasFocus ||
                                        locationController.text == '') {
                                      if (vm.savedLocation.any(
                                            (element) =>
                                                element.type == 'company',
                                          ) !=
                                          false) {
                                        locationController.text = vm
                                            .savedLocation
                                            .first
                                            .placeDescription!;
                                      }
                                    } else {
                                      if (vm.savedLocation.any(
                                            (element) =>
                                                element.type == 'company',
                                          ) !=
                                          false) {
                                        destinationController.text = vm
                                            .savedLocation
                                            .first
                                            .placeDescription!;
                                      }
                                    }
                                  },
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
                                                    location: e.type == 'other'
                                                        ? e
                                                        : null,
                                                    onTap: () {
                                                      if (locationFocusNode
                                                              .hasFocus ||
                                                          locationController
                                                                  .text ==
                                                              '') {
                                                        if (vm.savedLocation
                                                                .any(
                                                              (element) =>
                                                                  element
                                                                      .type ==
                                                                  'other',
                                                            ) !=
                                                            false) {
                                                          locationController
                                                                  .text =
                                                              vm
                                                                  .savedLocation
                                                                  .first
                                                                  .placeDescription!;
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      )
                                    : SizedBox(
                                        width: 5.w,
                                      ),
                                _SavePlaceItem(
                                  type: 2,
                                  location: null,
                                  onTap: () {
                                    Get.toNamed(MyRouter.addLocation,
                                        arguments: EnumHelper.getEnum(
                                          EnumMap.savePlaceType,
                                          2,
                                        ));
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                        Consumer<IBookingViewModel>(
                            builder: (context, vm, child) {
                          return Column(
                            children: [
                              Container(
                                child: vm.onSearchPlace == true
                                    ? Container(
                                        height: 300.h,
                                        color: Colors.white,
                                        child: Center(
                                          child: lottie.Lottie.asset(
                                            "assets/lottie/loading_location.json",
                                            repeat: true,
                                            height: 300.h,
                                          ),
                                        ),
                                      )
                                    : vm.listPredictions.isNotEmpty &&
                                            (locationController.text != '' ||
                                                destinationController.text !=
                                                    '') &&
                                            (locationFocusNode.hasFocus ||
                                                destinationFocusNode.hasFocus)
                                        ? Container(
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children:
                                                  vm.listPredictions.map((e) {
                                                return InkWell(
                                                  onTap: () async {
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                    setState(() {});
                                                    if (locationFocusNode
                                                        .hasFocus) {
                                                      locationController.text =
                                                          e.description!;
                                                      currentLocation = e;
                                                      PlaceDto? searchLocation =
                                                          await _iBookingViewModel
                                                              .getPlaceById(
                                                                  currentLocation!
                                                                      .placeId!);
                                                      _animatedMapMove(
                                                        LatLng(
                                                          searchLocation!
                                                              .geometry!
                                                              .location!
                                                              .lat!,
                                                          searchLocation
                                                              .geometry!
                                                              .location!
                                                              .lng!,
                                                        ),
                                                        19,
                                                      );
                                                    } else {
                                                      destinationController
                                                              .text =
                                                          e.description!;
                                                      currentDestination = e;
                                                      PlaceDto? searchLocation =
                                                          await _iBookingViewModel
                                                              .getPlaceById(
                                                                  currentDestination!
                                                                      .placeId!);
                                                      _animatedMapMove(
                                                        LatLng(
                                                          searchLocation!
                                                              .geometry!
                                                              .location!
                                                              .lat!,
                                                          searchLocation
                                                              .geometry!
                                                              .location!
                                                              .lng!,
                                                        ),
                                                        19,
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
                              )
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () => Get.toNamed(MyRouter.addBooking),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Chọn từ bản đồ',
                  ),
                ],
              ),
            ),
          )
        ],
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
