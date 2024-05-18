import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:lottie/lottie.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/utils/text_style_utils.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';
import 'package:twg/ui/utils/handling_string_utils.dart';

class ComingApplyDialog extends StatefulWidget {
  final ApplyDto apply;
  final Function setBooking;

  const ComingApplyDialog({
    Key? key,
    required this.apply,
    required this.setBooking,
  }) : super(key: key);

  @override
  State<ComingApplyDialog> createState() => _ComingApplyDialogState();
}

class _ComingApplyDialogState extends State<ComingApplyDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yêu cầu mới',
                    style: TextStyleUtils.subHeadingBold.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                    ),
                    child: LinearTimer(
                      duration: const Duration(
                        seconds: 10,
                      ),
                      color: ColorUtils.primaryColor,
                      backgroundColor: ColorUtils.primaryColor.withOpacity(
                        0.2,
                      ),
                      forward: false,
                      onTimerEnd: () {
                        // Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.apply.applyer!.avatarUrl == avatarUrl
                          ? Lottie.asset(
                              'assets/lottie/avatar.json',
                              fit: BoxFit.fill,
                              height: 80.h,
                              width: 80.w,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  widget.apply.applyer!.avatarUrl.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 80.r,
                                height: 80.r,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      60.0,
                                    ),
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
                                child: Lottie.asset(
                                  "assets/lottie/loading_image.json",
                                  repeat: true,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.apply.applyer!.firstName.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            widget.apply.applyer!.phoneNumber ?? '',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(HandlingStringUtils.timeDistanceFromNow(
                          DateTime.parse(widget.apply.createdAt.toString()))),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.apply.dealPrice == 0
                            ? 'Thu nhập'
                            : 'Giá thương lượng',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        VietnameseMoneyFormatter()
                            .formatToVietnameseCurrency(
                                widget.apply.booking!.price.toString())
                            .toString(),
                        style: TextStyle(
                          color: ColorUtils.primaryColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorUtils.primaryColor.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.r,
                        )),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 10.w,
                    ),
                    child: const Text(
                      'Trả tiền mặt',
                      style: TextStyle(
                        color: ColorUtils.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Divider(
                color: Colors.grey.withOpacity(
                  0.2,
                ),
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40.w,
                        child: Lottie.asset(
                          "assets/lottie/person.json",
                          animate: true,
                          repeat: true,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 320.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.apply.booking?.startPointMainText ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(widget.apply.booking?.startPointAddress ?? "",
                                overflow: TextOverflow.ellipsis, maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40.w,
                        child: Lottie.asset(
                          "assets/lottie/location-booking.json",
                          repeat: true,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 320.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.apply.booking?.endPointMainText ?? "",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                            Text(
                              widget.apply.booking?.endPointAddress ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  borderRadius: 15.r,
                  onTap: () => Get.back(),
                  height: 50.h,
                  width: 100.w,
                  text: 'Đóng',
                  bgColor: Colors.grey,
                  textStyle: TextStyleUtils.subHeading2.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomButton(
                  borderRadius: 15.r,
                  onTap: () {
                    widget.setBooking(widget.apply.booking as BookingDto);
                    Get.offNamed(MyRouter.applyInBooking);
                  },
                  height: 50.h,
                  width: 250.w,
                  text: 'Đồng ý',
                  textStyle: TextStyleUtils.subHeading2.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedDivider extends StatefulWidget {
  const AnimatedDivider({super.key});

  @override
  _AnimatedDividerState createState() => _AnimatedDividerState();
}

class _AnimatedDividerState extends State<AnimatedDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust the duration as needed
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * _animation.value,
          child: const Divider(
            thickness: 1,
            color: ColorUtils.primaryColor,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
