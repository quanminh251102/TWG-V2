import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/ihome_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/common_widgets/custom_text_field.dart';
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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    mapController = MapController();
    _iHomeViewModel = context.read<IHomeViewModel>();
    Future.delayed(
      Duration.zero,
      () async {
        await _iHomeViewModel.initHome().then((value) {
          if (locator<GlobalData>().currentPosition != null) {
            customMarkers.add(
              buildPin(
                LatLng(
                  locator<GlobalData>().currentPosition!.latitude,
                  locator<GlobalData>().currentPosition!.longitude,
                ),
              ),
            );
            _animatedMapMove(
              LatLng(
                locator<GlobalData>().currentPosition!.latitude,
                locator<GlobalData>().currentPosition!.longitude,
              ),
              16,
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
      floatingActionButton: const CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
        value: CustomNavigationBar.home,
      ),
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
                  ZoomButtons(
                    alignment: Alignment.bottomRight,
                    zoomInColor: ColorUtils.white,
                    zoomOutColor: ColorUtils.white,
                    zoomInColorIcon: Colors.black,
                    zoomOutColorIcon: Colors.black,
                    myLocationColor: ColorUtils.primaryColor,
                    myLocationColorIcon: Colors.black,
                    onPressed: () {
                      _animatedMapMove(
                        LatLng(
                          locator<GlobalData>().currentPosition!.latitude,
                          locator<GlobalData>().currentPosition!.longitude,
                        ),
                        16,
                      );
                    },
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
                                                  16,
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
