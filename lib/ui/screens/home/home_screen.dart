import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ihome_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/inotification_viewmodal.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/common_widgets/custom_text_field.dart';
import 'package:twg/ui/common_widgets/notification_widget.dart';
import 'package:twg/ui/screens/home/widget/search_response_item.dart';
import 'package:twg/ui/screens/home/widget/zoom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:twg/ui/common_widgets/custom_bottom_navigation_bar.dart';
import 'package:twg/ui/common_widgets/custom_booking_floating_button.dart';

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
  final FocusNode _focusNode = FocusNode();

  late IChatRoomViewModel _iChatRoomViewModel;
  late ICallViewModel _iCallViewModel;
  final ISocketService _iSocketService = locator<ISocketService>();
  late IApplyViewModel _iApplyViewModel;
  late INotificationViewModel _iNotificationViewModel;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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

    Future.delayed(
      Duration.zero,
      () async {
        await _iHomeViewModel.initHome().then((value) {
          if (locator<GlobalData>().currentPosition != null) {
            _animatedMapMove(
              LatLng(
                locator<GlobalData>().currentPosition!.latitude,
                locator<GlobalData>().currentPosition!.longitude,
              ),
              19,
            );
          }
        });
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Trang chủ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: const [
          NotificationWidget(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        value: CustomNavigationBar.home,
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
                    padding: EdgeInsets.symmetric(
                      vertical: 100.h,
                    ),
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
                    style: LocationMarkerStyle(
                      marker: const DefaultLocationMarker(
                        color: ColorUtils.primaryColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      markerSize: const Size.square(
                        40,
                      ),
                      accuracyCircleColor: ColorUtils.primaryColor.withOpacity(
                        0.1,
                      ),
                      headingSectorColor: ColorUtils.primaryColor.withOpacity(
                        0.8,
                      ),
                      showAccuracyCircle: true,
                      headingSectorRadius: 120,
                    ),
                    moveAnimationDuration: Duration.zero, // disable animation
                  ),
                  MarkerLayer(
                    markers: customMarkers,
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
              Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        top: 20.h,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: CustomSearchField(
                          focusNode: _focusNode,
                          controller: _controller,
                          readOnly: false,
                          onChanged: (value) async {
                            await _iHomeViewModel.onSearch(value);
                          },
                        ),
                      ),
                    ),
                  ),
                  Consumer<IHomeViewModel>(
                    builder: (context, value, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Container(
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
                                      _controller.text != '' &&
                                      _focusNode.hasFocus
                                  ? Container(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: vm.listPredictions.map((e) {
                                          return InkWell(
                                            onTap: () async {
                                              _focusNode.unfocus();
                                              _controller.text =
                                                  e.description ?? "";
                                              setState(() {});
                                              PlaceDto? searchPlace = await vm
                                                  .getPlaceById(e.placeId!);
                                              if (searchPlace != null) {
                                                if (customMarkers.length > 1) {
                                                  customMarkers.removeLast();
                                                }
                                                customMarkers.add(
                                                  buildPin(
                                                    LatLng(
                                                      searchPlace.geometry!
                                                          .location!.lat!,
                                                      searchPlace.geometry!
                                                          .location!.lng!,
                                                    ),
                                                  ),
                                                );
                                                _animatedMapMove(
                                                  LatLng(
                                                    searchPlace.geometry!
                                                        .location!.lat!,
                                                    searchPlace.geometry!
                                                        .location!.lng!,
                                                  ),
                                                  19,
                                                );
                                              }
                                            },
                                            child: SearchResponseItem(
                                              description: e.description ?? "",
                                            ),
                                          );
                                        }).toList(),
                                      ))
                                  : const SizedBox.shrink(),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
