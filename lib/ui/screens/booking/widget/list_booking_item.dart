// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/router.dart';

class ListBookingItem extends StatefulWidget {
  final BookingDto booking;
  final AnimationController? animationController;
  final Animation<double>? animation;
  const ListBookingItem({
    Key? key,
    required this.booking,
    this.animationController,
    this.animation,
  }) : super(key: key);
  @override
  State<ListBookingItem> createState() => _ListBookingItemState();
}

class _ListBookingItemState extends State<ListBookingItem> {
  bool isNavigateChatRoom = false;
  bool isNavigateCreateApply = false;
  late IApplyViewModel _iApplyViewModel;
  late IBookingViewModel _iBookingViewModel;
  late IMessageViewModel _iMessageViewModel;
  late IChatRoomViewModel _iChatRoomViewModel;
  bool isMyList = false;

  String formatDistance(String distance) {
    List<String> parts = distance.split(' ');
    String numericPart = parts.first;
    double kilometers = double.parse(numericPart);
    return "${kilometers.toStringAsFixed(2)} km";
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 2:
        return ColorUtils.primaryColor;
      case 1:
        return Colors.green;
      default:
        return ColorUtils.primaryColor;
    }
  }

  String getStatus(int status) {
    BookingStatus bookingStatus =
        EnumHelper.getEnum(EnumMap.bookingStatus, status);
    return EnumHelper.getDescription(EnumMap.bookingStatus, bookingStatus);
  }

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
      CreateChatRoomDto(userId: widget.booking.authorId!.id),
    );
    if (value != null) {
      _iMessageViewModel.setCurrentChatRoom(value);
      Get.offNamed(MyRouter.message);
    }
  }

  void navigateCreateApply(BuildContext context) async {
    _iApplyViewModel.setBookingDto(widget.booking);
    Get.offNamed(MyRouter.createApply);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - widget.animation!.value), 0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  bottom: 20.h,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(
                            0.3,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.r),
                          bottomLeft: Radius.circular(8.r),
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(54.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 10.h,
                                left: 16.w,
                                right: 16.w,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    MyRouter.driverProfile,
                                    arguments: widget.booking.authorId,
                                  );
                                },
                                child: Row(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 10.w,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: ColorUtils.primaryColor,
                                            width: 2.w,
                                          )),
                                      height: 40.r,
                                      width: 40.r,
                                      child: CircleAvatar(
                                        radius: 25.r,
                                        backgroundImage: NetworkImage(
                                          widget.booking.authorId?.avatarUrl ??
                                              "",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.booking.authorId?.firstName ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 1.sw / 3,
                                        child: Text(
                                          DateFormat('HH:mm | dd/MM/yyyy')
                                              .format(DateTime.parse(
                                                  widget.booking.time ?? "")),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                      // Text(
                                      //   widget.booking.bookingType ?? "",
                                      //   style: TextStyle(
                                      //     fontSize: 14.sp,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        color: getStatusColor(
                                            widget.booking.status!),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: Text(
                                          getStatus(widget.booking.status!)
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  if (widget.booking.isFavorite != null)
                                    InkWell(
                                      onTap: () async {
                                        await _iBookingViewModel
                                            .saveBooking(widget.booking.id!);
                                      },
                                      child: widget.booking.isFavorite!
                                          ? const Icon(
                                              Icons.bookmark,
                                              color: Colors.amber,
                                            )
                                          : const Icon(
                                              Icons.bookmark_outline,
                                              color: Colors.black,
                                            ),
                                    )
                                ]),
                              ),
                            ),
                            Text(
                              widget.booking.content ?? "",
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              child: Divider(
                                color: Colors.grey.withOpacity(0.2),
                                thickness: 1,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: ColorUtils.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 1.sw / 1.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.booking
                                                      .startPointMainText ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            Text(
                                                widget.booking
                                                        .startPointAddress ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                                maxLines: 2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ),
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.2),
                                    thickness: 1,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        color: ColorUtils.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 1.sw / 1.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                widget.booking
                                                        .endPointMainText ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2),
                                            Text(
                                              widget.booking.endPointAddress ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                              ),
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
                              height: 40.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            60.r,
                          ),
                        ),
                        color: ColorUtils.primaryColor.withOpacity(
                          0.08,
                        ),
                      ),
                      height: 40.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 25.w,
                          ),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/distance.svg",
                                        color: ColorUtils.primaryColor,
                                        height: 30,
                                      ),
                                      Text(
                                        formatDistance(
                                            widget.booking.distance ?? ""),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/clock.svg",
                                        height: 30,
                                        color: ColorUtils.primaryColor,
                                      ),
                                      Text(
                                        widget.booking.duration ?? "",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/wallet.svg",
                                        color: ColorUtils.primaryColor,
                                        height: 30,
                                      ),
                                      Text(
                                        VietnameseMoneyFormatter()
                                            .formatToVietnameseCurrency(
                                          widget.booking.price.toString(),
                                        ),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.r),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () => navigateCreateApply(context),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorUtils.primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ColorUtils.grey.withOpacity(
                                        0.8,
                                      ),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white,
                                    size: 25.r,
                                  ),
                                ),
                              ))),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
