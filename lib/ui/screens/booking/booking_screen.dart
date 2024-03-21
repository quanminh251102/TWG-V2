import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/ui/common_widgets/custom_bottom_navigation_bar.dart';
import 'package:twg/ui/common_widgets/confirm_login_dialog.dart';
import 'package:twg/ui/common_widgets/custom_rive_nav.dart';
import 'package:twg/ui/screens/booking/widget/create_post_bottom_sheet.dart';
import 'package:lottie/lottie.dart' as lottie;

import 'widget/list_booking.dart';
part './widget/available_tab.dart';
part './widget/cancel_tab.dart';
part './widget/complete_tab.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = ["Hoạt động", "Dành cho bạn", "Đã đóng"];
  int current = 0;

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 60.w;
      case 1:
        return 170.w;
      case 2:
        return 305.w;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return 50.w;
      case 1:
        return 80.w;
      case 2:
        return 50.w;

      default:
        return 0;
    }
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBarV2(
        currentIndex: 0,
      ),
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Bài đăng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              if (locator<GlobalData>().currentUser != null) {
                Get.bottomSheet(
                  const CreatePostSheet(),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                );
              } else {
                Get.dialog(
                  const ConfirmLoginDialog(),
                );
              }
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            child: const CupertinoSearchTextField(),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.h,
              bottom: 5.h,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(
                    0.2,
                  ),
                ),
              ),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(tabs.length, (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: Text(
                                    tabs[index],
                                    style: TextStyle(
                                      fontSize: current == index ? 16 : 14,
                                      fontWeight: current == index
                                          ? FontWeight.bold
                                          : FontWeight.w300,
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
                    duration: const Duration(milliseconds: 800),
                    child: AnimatedContainer(
                      margin: const EdgeInsets.only(left: 10),
                      width: changeContainerWidth(),
                      height: 1.sh * 0.008,
                      decoration: BoxDecoration(
                        color: ColorUtils.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.fastLinearToSlowEaseIn,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: _AvailableBookingTab()),
        ],
      ),
    );
  }
}
