// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:twg/ui/common_widgets/custom_button.dart';
import 'package:twg/ui/screens/booking/pick_place_screen.dart';
import 'package:twg/ui/screens/booking/widget/booking_search_item.dart';
import 'package:twg/ui/screens/home/widget/zoom_button.dart';
import 'package:twg/ui/screens/location/widget/location_search_item.dart';
import 'package:twg/ui/screens/location/widget/recommend_text_field.dart';

class PickLocationScreen extends StatefulWidget {
  LocationDto? locationDto;
  PickLocationScreen({
    Key? key,
    this.locationDto,
  }) : super(key: key);

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen>
    with TickerProviderStateMixin {
  late IBookingViewModel _iBookingViewModel;
  late ILocationViewModel _iLocationViewModel;

  final pinMarkers = <Marker>[];
  final placeMarkers = <Marker>[];
  final location.Location _location = location.Location();
  late MapController mapController;

  final FocusNode locationFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  LatLng? startPointGeo;
  LatLng? endPointGeo;
  LatLng? latLng;
  int selectedPlaces = 0;

  bool isFocusPlace = false;
  bool isChooseFromMap = false;
  bool isContinue = false;

  final TextEditingController locationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  List<PlaceDetailDto>? recommendPlaces;

  String? title;

  late Stream<location.LocationData> _locationStream;
  Debouncer debouncer = Debouncer(
    milliseconds: 1500,
  );
  late BuildContext draggableSheetContext;
  double minExtent = 0.5;
  double maxExtent = 0.96;
  bool isExpanded = false;
  double initialExtent = 0.96;
  final controller = DraggableScrollableController();
  Marker buildPin(LatLng point, String description) => Marker(
        point: point,
        child: lottie.Lottie.asset(
          "assets/lottie/circle-location-2.json",
          repeat: true,
        ),
        width: 30.w,
        height: 30.h,
      );

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

    setState(() {});
    controller.forward();
  }

  Future<void> _toggleDraggableScrollableSheet() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    DraggableScrollableActuator.reset(
      draggableSheetContext,
    );
    await gotoPoint();
  }

  Future<void> gotoPoint() async {
    setState(() {
      isChooseFromMap = true;
    });

    _animatedMapMove(
      LatLng(
        locator<GlobalData>().currentPosition!.latitude,
        locator<GlobalData>().currentPosition!.longitude,
      ),
      19,
    );
  }

  Future<void> updatePoint(BuildContext context) async {
    latLng = mapController.camera.center;
    if (isChooseFromMap) {
      pinMarkers.clear();
      pinMarkers.add(Marker(
        point: latLng!,
        child: lottie.Lottie.asset(
          "assets/lottie/location.json",
          repeat: true,
        ),
        width: 60.w,
        height: 60.h,
      ));
      if (!isFocusPlace) {
        selectedPlaces = 0;
        debouncer.run(() async {
          placeMarkers.clear();
          recommendPlaces = await _iBookingViewModel.getPlaceByGeocode(latLng!);
          for (var element in recommendPlaces!) {
            placeMarkers.add(
              buildPin(
                LatLng(
                  element.geometry!.location!.lat!,
                  element.geometry!.location!.lng!,
                ),
                element.formattedAddress.toString(),
              ),
            );
          }
          setState(() {});
        });
      }
    }
  }

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

  void updateTitle() {
    setState(() {
      if (locationFocusNode.hasFocus) {
        title = 'Điểm đi';
      } else if (destinationFocusNode.hasFocus) {
        title = 'Điểm đến';
      }
    });
    controller.animateTo(
      maxExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutBack,
    );
  }

  Future<void> conditionCheck() async {
    controller.animateTo(
      minExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutBack,
    );
    setState(() {
      isContinue = true;
    });
    _iLocationViewModel.updateRecommendLocation(startPointGeo, endPointGeo);
    await _iBookingViewModel.getRecommendBooking(
      type: "from_input",
      startPointLat: startPointGeo!.latitude,
      startPointLong: startPointGeo!.longitude,
      endPointLat: endPointGeo!.latitude,
      endPointLong: endPointGeo!.longitude,
    );
    Get.toNamed(MyRouter.loadingRecommend);
  }

  @override
  void initState() {
    _iLocationViewModel = context.read<ILocationViewModel>();
    _iBookingViewModel = context.read<IBookingViewModel>();

    _iBookingViewModel.listPredictions.clear();
    mapController = MapController();
    draggableSheetContext = context;
    _locationStream = _location.onLocationChanged;

    locationFocusNode.requestFocus();
    locationFocusNode.addListener(updateTitle);
    destinationFocusNode.addListener(updateTitle);

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
                    onPositionChanged: (_, __) async {
                      await updatePoint(context);
                    },
                    onPointerDown: (event, point) {
                      isFocusPlace = false;
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
          isChooseFromMap
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Consumer<IBookingViewModel>(
                        builder: (context, vm, child) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
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
                                  title ?? '',
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
                                  : vm.recommendPlaces != null
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.36,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: vm.recommendPlaces!
                                                    .map((e) {
                                                  var index = vm
                                                      .recommendPlaces!
                                                      .indexOf(e);
                                                  return InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        if (selectedPlaces !=
                                                            index) {
                                                          selectedPlaces =
                                                              index;
                                                        }
                                                        isFocusPlace = true;
                                                      });
                                                      _animatedMapMove(
                                                          LatLng(
                                                            e.geometry!
                                                                .location!.lat!,
                                                            e.geometry!
                                                                .location!.lng!,
                                                          ),
                                                          19);
                                                    },
                                                    child: LocationSearchItem(
                                                      isSelected:
                                                          selectedPlaces ==
                                                              index,
                                                      placeDetail: e,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            CustomButton(
                                              height: 50.h,
                                              width: 300.w,
                                              text: 'Xác nhận',
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                              onTap: () async {},
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                )
              : DraggableScrollableSheet(
                  key: Key(initialExtent.toString()),
                  controller: controller,
                  initialChildSize: initialExtent,
                  minChildSize: minExtent,
                  maxChildSize: maxExtent,
                  snapSizes: [minExtent, maxExtent],
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
                                  title ?? '',
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
                                locationTextEditingController:
                                    locationController,
                                destinationTextEditingController:
                                    destinationController,
                                locationFocusNode: locationFocusNode,
                                destinationFocusNode: destinationFocusNode,
                                onLocationChanged: (value) async {
                                  if (value.length >= 3) {
                                    await _iBookingViewModel.onPickPlace(value);
                                  }
                                  setState(() {});
                                },
                                onDestinationChanged: (value) async {
                                  if (value.length >= 3) {
                                    await _iBookingViewModel.onPickPlace(value);
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Consumer<ILocationViewModel>(
                              builder: (context, vm, child) {
                                bool hasType1 = vm.savedLocation.any(
                                    (element) => element.type == 'company');

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (var savedLocation
                                          in vm.savedLocation)
                                        if (savedLocation.type == 'home' ||
                                            savedLocation.type == 'company' ||
                                            savedLocation.type == 'other')
                                          _SavePlaceItem(
                                            type: savedLocation.type == 'home'
                                                ? 0
                                                : (savedLocation.type ==
                                                        'company'
                                                    ? 1
                                                    : 2),
                                            location: savedLocation,
                                            onTap: () {
                                              if (locationFocusNode.hasFocus ||
                                                  locationController
                                                      .text.isEmpty) {
                                                locationController.text =
                                                    savedLocation
                                                        .placeDescription!;
                                              } else {
                                                destinationController.text =
                                                    savedLocation
                                                        .placeDescription!;
                                              }
                                              setState(() {
                                                isContinue = true;
                                              });
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
                            Consumer<IBookingViewModel>(
                              builder: (context, vm, child) {
                                bool hasPredictions =
                                    vm.listPredictions.isNotEmpty &&
                                        (locationController.text.isNotEmpty ||
                                            destinationController
                                                .text.isNotEmpty) &&
                                        (locationFocusNode.hasFocus ||
                                            destinationFocusNode.hasFocus);
                                return Column(
                                  children: [
                                    if (vm.onSearchPlace)
                                      Container(
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
                                    else if (hasPredictions)
                                      Container(
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: vm.listPredictions.map((e) {
                                            return InkWell(
                                              onTap: () async {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                LatLng? point;
                                                PlaceDto? searchLocation =
                                                    await _iBookingViewModel
                                                        .getPlaceById(
                                                            e.placeId!);
                                                point = LatLng(
                                                  searchLocation!
                                                      .geometry!.location!.lat!,
                                                  searchLocation
                                                      .geometry!.location!.lng!,
                                                );
                                                if (locationFocusNode
                                                    .hasFocus) {
                                                  locationController.text =
                                                      e.description!;
                                                  startPointGeo = point;
                                                } else {
                                                  destinationController.text =
                                                      e.description!;
                                                  endPointGeo = point;
                                                }
                                                if (locationController
                                                        .text.isNotEmpty &&
                                                    destinationController
                                                        .text.isNotEmpty) {
                                                  conditionCheck();
                                                } else {
                                                  _animatedMapMove(
                                                    point,
                                                    19,
                                                  );
                                                  if (!pinMarkers.any(
                                                      (element) =>
                                                          element.point ==
                                                          point)) {
                                                    pinMarkers.clear();
                                                    pinMarkers.add(
                                                      Marker(
                                                        point: point,
                                                        child:
                                                            lottie.Lottie.asset(
                                                          "assets/lottie/location.json",
                                                          repeat: true,
                                                        ),
                                                        width: 60.w,
                                                        height: 60.h,
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: BookingSearchItem(
                                                  predictions: e),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
          !isChooseFromMap
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => _toggleDraggableScrollableSheet(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.map_outlined),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Text(
                          'Chọn từ bản đồ',
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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
