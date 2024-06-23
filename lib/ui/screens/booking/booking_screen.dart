// ignore_for_file: public_member_api_docs, sort_constructors_firs
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';

import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ihome_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ilocation_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/inotification_viewmodal.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/animation/ani_bottom_sheet.dart';
import 'package:twg/ui/common_widgets/custom_rive_nav.dart';
import 'package:twg/ui/screens/booking/widget/list_recommend_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/view_models/interfaces/iapply_viewmodel.dart';
import 'widget/list_booking.dart';

part './widget/available_tab.dart';
part './widget/filter_dialog.dart';
part './widget/saved_booking_tab.dart';

class BookingScreen extends StatefulWidget {
  final bool isRecommend;
  const BookingScreen({
    Key? key,
    required this.isRecommend,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  late IChatRoomViewModel _iChatRoomViewModel;
  late ICallViewModel _iCallViewModel;
  final ISocketService _iSocketService = locator<ISocketService>();
  late IApplyViewModel _iApplyViewModel;
  late INotificationViewModel _iNotificationViewModel;
  late IHomeViewModel _iHomeViewModel;
  late IBookingViewModel _iBookingViewModel;
  late TabController _tabController;
  late AnimationController animationController;
  final TextEditingController _searchController = TextEditingController();
  int current = 0;
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0;
  bool? isRecommend = false;
  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 1.sw / 7;
      case 1:
        return 1.sw / 1.55;
      default:
        return 0;
    }
  }

  String getTabTitle(int index) {
    switch (index) {
      case 0:
        return "Hoạt động";
      case 1:
        return "Đã lưu";
      default:
        return "";
    }
  }

  @override
  void initState() {
    isRecommend = widget.isRecommend;
    _iHomeViewModel = context.read<IHomeViewModel>();
    _iBookingViewModel = context.read<IBookingViewModel>();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
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
    Future.delayed(
      Duration.zero,
      () async {
        await _iHomeViewModel.initHome();
      },
    );
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void openFilterDialog() {
      Get.bottomSheet(
        FilterDialog(
          onTap: () async {
            await _iBookingViewModel.onSearchBooking();
          },
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      );
    }

    List<Widget> tabs = [
      _AvailableBookingTab(
        animationController: animationController,
        scrollCallback: (scrollOffset) {
          if (scrollOffset >= 24) {
            if (topBarOpacity != 1.0) {
              setState(() {
                topBarOpacity = 1.0;
              });
            }
          } else if (scrollOffset <= 24 && scrollOffset >= 0) {
            if (topBarOpacity != scrollOffset / 24) {
              setState(() {
                topBarOpacity = scrollOffset / 24;
              });
            }
          } else if (scrollOffset <= 0) {
            if (topBarOpacity != 0.0) {
              setState(() {
                topBarOpacity = 0.0;
              });
            }
          }
        },
      ),
      _SaveBookingTab(
        animationController: animationController,
        scrollCallback: (scrollOffset) {
          if (scrollOffset >= 24) {
            if (topBarOpacity != 1.0) {
              setState(() {
                topBarOpacity = 1.0;
              });
            }
          } else if (scrollOffset <= 24 && scrollOffset >= 0) {
            if (topBarOpacity != scrollOffset / 24) {
              setState(() {
                topBarOpacity = scrollOffset / 24;
              });
            }
          } else if (scrollOffset <= 0) {
            if (topBarOpacity != 0.0) {
              setState(() {
                topBarOpacity = 0.0;
              });
            }
          }
        },
      )
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: const BottomNavBarV2(
        currentIndex: 0,
      ),
      extendBody: true,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top * 2),
              Expanded(
                child: tabs[current],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) {
                    return FadeTransition(
                      opacity: topBarAnimation!,
                      child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(topBarOpacity),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.4 * topBarOpacity),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16 - 8.0 * topBarOpacity,
                                    bottom: 12 - 10.0 * topBarOpacity),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Bài đăng',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                22 + 6 - 6 * topBarOpacity,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 0.h,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                width: 1.sw,
                                height: 1.sh * 0.06,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10.h,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: SizedBox(
                                            width: 1.sw,
                                            height: 1.sh * 0.04,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                    tabs.length, (index) {
                                                  return SizedBox(
                                                    width: 1.sw / 2,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 30.w,
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            current = index;
                                                            isRecommend = false;
                                                          });
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            getTabTitle(index),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  current ==
                                                                          index
                                                                      ? 16
                                                                      : 14,
                                                              fontWeight: current ==
                                                                      index
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList()),
                                          )),
                                      AnimatedPositioned(
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        bottom: 0,
                                        left: changePositionedOfLine(),
                                        duration:
                                            const Duration(milliseconds: 800),
                                        child: AnimatedContainer(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          width: 80.w,
                                          height: 1.sh * 0.008,
                                          decoration: BoxDecoration(
                                            color: ColorUtils.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: CupertinoSearchTextField(
                                      controller: _searchController,
                                      onSuffixTap: () async {
                                        _searchController.text = '';
                                        _iBookingViewModel.filterBookingDto
                                            ?.keyword = _searchController.text;
                                        await _iBookingViewModel
                                            .onSearchBooking();
                                      },
                                      onSubmitted: (value) async {
                                        _iBookingViewModel
                                            .filterBookingDto?.keyword = value;
                                        await _iBookingViewModel
                                            .onSearchBooking();
                                      },
                                    )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                      ),
                                      child: Container(
                                        height: 30.r,
                                        width: 30.r,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                blurRadius: 10.r,
                                                spreadRadius: 1,
                                                offset: const Offset(
                                                  4,
                                                  4,
                                                ),
                                              ),
                                              BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 10.r,
                                                spreadRadius: 1,
                                                offset: const Offset(
                                                  -4,
                                                  -4,
                                                ),
                                              )
                                            ]),
                                        child: GestureDetector(
                                          onTap: () => openFilterDialog(),
                                          child: const Icon(
                                            CupertinoIcons.layers,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          )
        ],
      ),
    );
  }
}
