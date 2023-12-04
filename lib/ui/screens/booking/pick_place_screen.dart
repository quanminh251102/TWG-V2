import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:twg/ui/common_widgets/custom_button.dart';
import 'package:twg/ui/screens/booking/widget/booking_search_item.dart';
import 'package:twg/ui/screens/booking/widget/place_text_field.dart';
import 'package:twg/ui/screens/booking/widget/save_place_box.dart';

class PickPlaceScreen extends StatefulWidget {
  const PickPlaceScreen({super.key});

  @override
  State<PickPlaceScreen> createState() => _PickPlaceScreenState();
}

class _PickPlaceScreenState extends State<PickPlaceScreen>
    with TickerProviderStateMixin {
  static const double pointSize = 55;
  static const double pointY = 120;

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  late final MapController mapController;
  final pinMarkers = <Marker>[];
  final placeMarkers = <Marker>[];
  LatLng? latLng;
  bool isPickFromMap = false;

  late IBookingViewModel _iBookingViewModel;

  final FocusNode locationFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  Predictions? currentLocation;
  Predictions? currentDestination;

  static const double minExtent = 0.2;
  static const double maxExtent = 1;

  double initialExtent = maxExtent;
  late BuildContext draggableSheetContext;
  bool hideSuggestLocations = false;
  bool isInit = false;
  bool isLocationFocus = true;
  bool isGetPlace = false;
  Debouncer debouncer = Debouncer(
    milliseconds: 1500,
  );

  @override
  void initState() {
    mapController = MapController();
    draggableSheetContext = context;

    locationFocusNode.addListener(() {
      if (locationFocusNode.hasFocus) {
        setState(() {
          initialExtent = maxExtent;
          hideSuggestLocations = false;
          isLocationFocus = true;
        });
        DraggableScrollableActuator.reset(draggableSheetContext);
      }
    });

    destinationFocusNode.addListener(() {
      if (destinationFocusNode.hasFocus) {
        setState(() {
          initialExtent = maxExtent;
          hideSuggestLocations = false;
          isLocationFocus = false;
        });
        DraggableScrollableActuator.reset(draggableSheetContext);
      }
    });

    _iBookingViewModel = context.read<IBookingViewModel>();
    _iBookingViewModel.initData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updatePoint(context);
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
      isInit = true;
    });

    super.initState();
  }

  @override
  void dispose() {
    locationFocusNode.dispose();
    destinationFocusNode.dispose();
    super.dispose();
  }

  void _toggleDraggableScrollableSheet() {
    isLocationFocus = locationFocusNode.hasFocus;
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setState(() {
      initialExtent = minExtent;
    });
    DraggableScrollableActuator.reset(
      draggableSheetContext,
    );
  }

  Future<void> gotoPoint() async {
    if (isLocationFocus) {
      PlaceDto? searchPlace =
          await _iBookingViewModel.getPlaceById(currentLocation!.placeId!);
      if (searchPlace != null) {
        _animatedMapMove(
          LatLng(
            searchPlace.geometry!.location!.lat!,
            searchPlace.geometry!.location!.lng!,
          ),
          19,
        );
      }
    } else {
      PlaceDto? searchPlace =
          await _iBookingViewModel.getPlaceById(currentDestination!.placeId!);
      if (searchPlace != null) {
        _animatedMapMove(
          LatLng(
            searchPlace.geometry!.location!.lat!,
            searchPlace.geometry!.location!.lng!,
          ),
          19,
        );
      }
    }
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

    controller.forward();
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
        actions: [
          Visibility(
            visible: initialExtent == maxExtent &&
                (locationFocusNode.hasFocus || destinationFocusNode.hasFocus),
            child: InkWell(
              onTap: () async {
                await gotoPoint();
                _toggleDraggableScrollableSheet();
              },
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
            child: PlaceTextField(
              isFocus: isLocationFocus,
              locationTextEditingController: locationController,
              destinationTextEditingController: destinationController,
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
          Expanded(
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: hideSuggestLocations ? double.infinity : 540.h,
                  ),
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      onPositionChanged: (_, __) => updatePoint(context),
                      onPointerHover: (event, point) {
                        setState(() {
                          if (isInit) {
                            hideSuggestLocations = true;
                          }
                        });
                      },
                      initialCenter: LatLng(
                        locator<GlobalData>().currentPosition!.latitude,
                        locator<GlobalData>().currentPosition!.longitude,
                      ),
                      initialZoom: 19,
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
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      MarkerLayer(
                        markers: pinMarkers,
                        alignment: Alignment.topCenter,
                      ),
                      MarkerLayer(
                        markers: placeMarkers,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: !hideSuggestLocations
                      ? pointY - pointSize / 2 + 110.h
                      : pointY - pointSize / 2 + 162.h,
                  left: !hideSuggestLocations
                      ? _getPointX(context) - pointSize / 2
                      : _getPointX(context) - pointSize / 2,
                  child: IgnorePointer(
                    child: lottie.Lottie.asset(
                      "assets/lottie/location.json",
                      repeat: true,
                      height: 60.h,
                      width: 60.h,
                    ),
                  ),
                ),
                hideSuggestLocations
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: CustomButton(
                            height: 50.h,
                            width: 300.w,
                            text: 'Xác nhận',
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                            onTap: () {
                              setState(() {
                                initialExtent = maxExtent;
                                hideSuggestLocations = false;
                              });
                              FocusManager.instance.primaryFocus?.unfocus();
                              DraggableScrollableActuator.reset(
                                  draggableSheetContext);
                            },
                          ),
                        ),
                      )
                    : DraggableScrollableSheet(
                        snap: true,
                        key: Key(initialExtent.toString()),
                        minChildSize: minExtent,
                        maxChildSize: maxExtent,
                        initialChildSize: initialExtent,
                        shouldCloseOnMinExtent: true,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return Consumer<IBookingViewModel>(
                            builder: (context, vm, child) {
                              return Container(
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                          15.r,
                                        ),
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.bookmark,
                                                  color:
                                                      ColorUtils.primaryColor,
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                      height: 300.h),
                                                ),
                                              )
                                            : vm.listPredictions.isNotEmpty &&
                                                    (locationController.text !=
                                                            '' ||
                                                        destinationController
                                                                .text !=
                                                            '') &&
                                                    (locationFocusNode
                                                            .hasFocus ||
                                                        destinationFocusNode
                                                            .hasFocus)
                                                ? Container(
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: vm
                                                          .listPredictions
                                                          .map((e) {
                                                        return InkWell(
                                                          onTap: () async {
                                                            if (locationFocusNode
                                                                .hasFocus) {
                                                              locationFocusNode
                                                                  .unfocus();
                                                              locationController
                                                                      .text =
                                                                  e.description!;
                                                              currentLocation =
                                                                  e;
                                                            } else {
                                                              destinationFocusNode
                                                                  .unfocus();
                                                              destinationController
                                                                      .text =
                                                                  e.description!
                                                                      .split(
                                                                          ',')[0];
                                                              currentDestination =
                                                                  e;
                                                            }
                                                            setState(() {});
                                                          },
                                                          child:
                                                              BookingSearchItem(
                                                            predictions: e,
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ))
                                                : const SizedBox.shrink(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  void updatePoint(BuildContext context) async {
    latLng = mapController.camera.center;
    setValuePlaceField();
  }

  void setValuePlaceField() {
    if (isLocationFocus) {
      debouncer.run(() async {
        List<PlaceDetailDto>? placeDetailDto =
            await _iBookingViewModel.getPlaceByGeocode(
          latLng!,
        );
        setState(() {
          locationController.text =
              placeDetailDto![0].formattedAddress!.toString();
          locationController.selection = TextSelection.fromPosition(
            const TextPosition(offset: 0),
          );
          currentLocation = Predictions(placeId: placeDetailDto[0].placeId);
          pinMarkers.clear();
          for (var element in placeDetailDto) {
            pinMarkers.add(
              buildPin(
                LatLng(
                  element.geometry!.location!.lat!,
                  element.geometry!.location!.lng!,
                ),
                element.formattedAddress.toString(),
              ),
            );
          }
        });
      });
    } else {
      debouncer.run(() async {
        List<PlaceDetailDto>? placeDetailDto =
            await _iBookingViewModel.getPlaceByGeocode(
          latLng!,
        );
        setState(() {
          destinationController.text =
              placeDetailDto![0].formattedAddress!.toString();
          destinationController.selection = TextSelection.fromPosition(
            const TextPosition(offset: 0),
          );
          currentDestination = Predictions(placeId: placeDetailDto[0].placeId);
          pinMarkers.clear();
          for (var element in placeDetailDto) {
            pinMarkers.add(
              buildPin(
                LatLng(
                  element.geometry!.location!.lat!,
                  element.geometry!.location!.lng!,
                ),
                element.formattedAddress.toString(),
              ),
            );
          }
        });
      });
    }
  }

  double _getPointX(BuildContext context) =>
      MediaQuery.sizeOf(context).width / 2;
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
