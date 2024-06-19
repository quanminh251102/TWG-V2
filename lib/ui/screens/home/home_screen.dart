// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/booking/widget/auto_complete/auto_complete.dart';
import 'package:twg/ui/screens/booking/widget/auto_complete/options.dart';
import 'package:twg/ui/common_widgets/booking_dialog.dart';
import 'package:twg/ui/common_widgets/custom_rive_nav.dart';

import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ihome_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/inotification_viewmodal.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/screens/home/widget/zoom_button.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  final TextEditingController _controller = TextEditingController();
  late IHomeViewModel _iHomeViewModel;
  late final MapController mapController;

  late final customMarkers = <Marker>[];
  late final bookingMarkers = <Marker>[];

  late IChatRoomViewModel _iChatRoomViewModel;
  late ICallViewModel _iCallViewModel;
  final ISocketService _iSocketService = locator<ISocketService>();
  late IApplyViewModel _iApplyViewModel;
  late INotificationViewModel _iNotificationViewModel;
  late IBookingViewModel _iBookingViewModel;
  final FieldSettings settings = FieldSettings();

  @override
  void initState() {
    if (!locator<GlobalData>().isInitSocket) {
      _iChatRoomViewModel = context.read<IChatRoomViewModel>();
      _iChatRoomViewModel.initSocketEventForChatRoom();

      _iApplyViewModel = context.read<IApplyViewModel>();
      _iApplyViewModel.initSocketEventForApply();

      _iNotificationViewModel = context.read<INotificationViewModel>();
      _iNotificationViewModel.initSocketEventForNotification();

      _iCallViewModel = context.read<ICallViewModel>();
      _iCallViewModel.initSocketEventForCall();
      _iCallViewModel.setSocket(_iSocketService.socket as IO.Socket);

      locator<GlobalData>().isInitSocket = true;
    }

    mapController = MapController();
    _iHomeViewModel = context.read<IHomeViewModel>();
    _iBookingViewModel = context.read<IBookingViewModel>();
    Future.delayed(
      Duration.zero,
      () async {
        _iBookingViewModel.setIsMyList(false);
        await _iBookingViewModel
            .initHome(
              EnumHelper.getDescription(
                EnumMap.bookingStatus,
                BookingStatus.available,
              ),
            )
            .then((value) => {
                  for (var booking in _iBookingViewModel.bookings)
                    {
                      if (booking.startPointLat != null &&
                          booking.startPointLong != null)
                        {
                          bookingMarkers.add(
                            bookingPin(
                                LatLng(
                                  double.parse(
                                      booking.startPointLat.toString()),
                                  double.parse(
                                    booking.startPointLong.toString(),
                                  ),
                                ),
                                booking),
                          )
                        }
                    }
                });
        _animatedMapMove(
          LatLng(
            locator<GlobalData>().currentPosition!.latitude,
            locator<GlobalData>().currentPosition!.longitude,
          ),
          19,
        );
      },
    );

    super.initState();
  }

  Marker buildPin(LatLng point) => Marker(
        point: point,
        child: lottie.Lottie.asset(
          "assets/lottie/location.json",
          repeat: true,
        ),
        width: 60.w,
        height: 60.h,
      );
  Marker bookingPin(LatLng point, BookingDto bookingDto) => Marker(
        point: point,
        child: CustomMarker(
          bookingDto: bookingDto,
        ),
        width: 60.w,
        height: 60.h,
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

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBarV2(
        currentIndex: 1,
      ),
      extendBody: true,
      body: Consumer<IHomeViewModel>(
        builder: (context, vm, child) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: const LatLng(
                    10.870,
                    106.803,
                  ),
                  initialZoom: 18,
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
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 100.h,
                    ),
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        MyRouter.chatbotScreen,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          'assets/lottie/chatbot.gif',
                          fit: BoxFit.cover,
                          height: 120.h,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 100.h, horizontal: 10.w),
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
                  // CurrentLocationLayer(
                  //   style: LocationMarkerStyle(
                  //     marker: const DefaultLocationMarker(
                  //       color: ColorUtils.primaryColor,
                  //       child: Icon(
                  //         Icons.person,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     markerSize: const Size.square(
                  //       40,
                  //     ),
                  //     accuracyCircleColor: ColorUtils.primaryColor.withOpacity(
                  //       0.1,
                  //     ),
                  //     headingSectorColor: ColorUtils.primaryColor.withOpacity(
                  //       0.8,
                  //     ),
                  //     showAccuracyCircle: true,
                  //     headingSectorRadius: 120,
                  //   ),
                  //   moveAnimationDuration: Duration.zero, // disable animation
                  // ),
                  MarkerLayer(
                    markers: customMarkers,
                    alignment: Alignment.topCenter,
                  ),
                  MarkerLayer(
                    markers: bookingMarkers,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: kToolbarHeight,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: AutoCompleteField(
                      controller: _controller,
                      settings: settings,
                      onSuggestionSelected: (Predictions predictions) async {
                        if (predictions.description!.toLowerCase() !=
                            _controller.text.toLowerCase()) {
                          _controller.text = predictions.description ?? "";
                          setState(() {});
                          PlaceDto? searchPlace =
                              await vm.getPlaceById(predictions.placeId!);
                          if (searchPlace != null) {
                            if (customMarkers.length > 1) {
                              customMarkers.removeLast();
                            }
                            customMarkers.add(
                              buildPin(
                                LatLng(
                                  searchPlace.geometry!.location!.lat!,
                                  searchPlace.geometry!.location!.lng!,
                                ),
                              ),
                            );
                            _animatedMapMove(
                              LatLng(
                                searchPlace.geometry!.location!.lat!,
                                searchPlace.geometry!.location!.lng!,
                              ),
                              19,
                            );
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomMarker extends StatefulWidget {
  final BookingDto bookingDto;
  const CustomMarker({
    Key? key,
    required this.bookingDto,
  }) : super(key: key);

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          BookingDialog(
            bookingDto: widget.bookingDto,
          ),
          isDismissible: true,
          enableDrag: false,
        );
      },
      child: lottie.Lottie.asset(
        "assets/lottie/booking_marker.json",
        repeat: true,
      ),
    );
  }
}
