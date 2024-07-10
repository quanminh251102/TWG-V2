import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/utils/text_style_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/utils/handling_string_utils.dart';

class BookingDialog extends StatefulWidget {
  final BookingDto bookingDto;

  const BookingDialog({
    Key? key,
    required this.bookingDto,
  }) : super(key: key);

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  bool isMyList = false;
  bool isNavigateChatRoom = false;
  bool isNavigateCreateApply = false;
  late IApplyViewModel _iApplyViewModel;
  late IBookingViewModel _iBookingViewModel;
  late IMessageViewModel _iMessageViewModel;
  late IChatRoomViewModel _iChatRoomViewModel;
  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iMessageViewModel = context.read<IMessageViewModel>();
    _iChatRoomViewModel = context.read<IChatRoomViewModel>();
    isMyList = _iBookingViewModel.isMyList;
    super.initState();
  }

  void navigateChatRoom(BuildContext context) async {
    var value = await _iChatRoomViewModel.createChatRoom(
      CreateChatRoomDto(userId: widget.bookingDto.authorId!.id),
    );
    if (value != null) {
      _iMessageViewModel.setCurrentChatRoom(value);
      Get.offNamed(MyRouter.message);
    }
  }

  void navigateCreateApply(BuildContext context) async {
    _iApplyViewModel.setBookingDto(widget.bookingDto);
    Get.offNamed(MyRouter.createApply);
  }

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
                    'Thông tin chuyến đi',
                    style: TextStyleUtils.subHeadingBold.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
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
                      widget.bookingDto.authorId!.avatarUrl == avatarUrl
                          ? Lottie.asset(
                              'assets/lottie/avatar.json',
                              fit: BoxFit.fill,
                              height: 80.h,
                              width: 80.w,
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.bookingDto.authorId!.avatarUrl
                                  .toString(),
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
                            widget.bookingDto.authorId!.firstName.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            widget.bookingDto.authorId!.phoneNumber ?? '',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(HandlingStringUtils.timeDistanceFromNow(
                          DateTime.parse(
                              widget.bookingDto.createdAt.toString()))),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookingDto.price == 0
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
                                widget.bookingDto.price!.round().toString())
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
                              widget.bookingDto.startPointMainText ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(widget.bookingDto.startPointAddress ?? "",
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
                            Text(widget.bookingDto.endPointMainText ?? "",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                            Text(
                              widget.bookingDto.endPointAddress ?? "",
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
            if (widget.bookingDto.authorId!.id ==
                locator<GlobalData>().currentUser!.id)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _iApplyViewModel.setBookingDto(widget.bookingDto);
                    Get.offNamed(MyRouter.applyInBooking);
                  },
                  child: const Text('Danh sách'),
                ),
              ),
            if (widget.bookingDto.authorId!.id !=
                locator<GlobalData>().currentUser!.id)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (isNavigateChatRoom)
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () {
                                navigateChatRoom(context);
                              },
                              child: Container(
                                width: 150.w,
                                decoration: BoxDecoration(
                                    color: ColorUtils.primaryColor,
                                    border: Border.all(
                                      color: ColorUtils.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15.h,
                                    horizontal: 30.w,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Trò chuyện',
                                      style: TextStyle(
                                        color: ColorUtils.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      (isNavigateCreateApply)
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () {
                                navigateCreateApply(context);
                              },
                              child: Container(
                                width: 150.w,
                                decoration: BoxDecoration(
                                    color: ColorUtils.primaryColor,
                                    border: Border.all(
                                      color: ColorUtils.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15.h,
                                    horizontal: 30.w,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Tham gia',
                                      style: TextStyle(
                                          color: ColorUtils.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ]),
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
      duration:
          const Duration(milliseconds: 500), // Adjust the duration as needed
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
