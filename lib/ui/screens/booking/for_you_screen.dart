import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/text_style_utils.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ilocation_viewmodel.dart';
import 'package:twg/ui/common_widgets/custom_rive_nav.dart';
import 'package:twg/ui/screens/booking/widget/list_booking.dart';
import 'package:twg/ui/screens/booking/widget/recommend_text_field.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen>
    with TickerProviderStateMixin {
  late IBookingViewModel _iBookingViewModel;
  late ILocationViewModel _iLocationViewModel;
  late AnimationController animationController;
  Animation<double>? topBarAnimation;
  late ScrollController scrollController;
  double topBarOpacity = 0.0;

  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iLocationViewModel = context.read<ILocationViewModel>();
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

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    Future.delayed(
      Duration.zero,
      () async {
        await _iLocationViewModel.getSavedLocation();
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      Get.bottomSheet(
        const HintDialog(),
        isDismissible: true,
        enableDrag: false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: kToolbarHeight + 170.h,
              ),
              Expanded(
                child: Consumer<IBookingViewModel>(
                  builder: (context, vm, child) {
                    animationController.forward();
                    return ListBooking(
                      controller: scrollController,
                      bookings: vm.recommendBooking,
                      mainScreenAnimation:
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: const Interval(
                            (1 / 10) * 3,
                            1.0,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      mainScreenAnimationController: animationController,
                    );
                  },
                ),
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
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 18.sp,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Dành cho bạn',
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
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                ),
                                child: const RecommendTextField(),
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

class HintDialog extends StatelessWidget {
  const HintDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 130.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r),
                          topRight: Radius.circular(8.r)),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Mẹo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0.w,
                              ),
                              child: Divider(
                                color: Colors.grey.withOpacity(
                                  0.2,
                                ),
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 30.w,
                                  bottom: 10.h,
                                  right: 30.w,
                                  top: 10.h),
                              child: Text(
                                'Hãy thử tìm kiếm để chúng tôi gợi ý bạn những chuyến đi phù hợp nhất nhé !',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: InkWell(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -12,
                  left: 0,
                  child: SizedBox(
                    width: 60.r,
                    height: 60.r,
                    child: Image.asset("assets/images/idea.png"),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
