// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

class ListRecommendItem extends StatefulWidget {
  final BookingDto booking;
  // final AnimationController? animationController;
  // final Animation<double>? animation;
  const ListRecommendItem({
    Key? key,
    required this.booking,
    // this.animationController,
    // this.animation,
  }) : super(key: key);
  @override
  State<ListRecommendItem> createState() => _ListRecommendItemState();
}

class _ListRecommendItemState extends State<ListRecommendItem> {
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
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Container(
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
            topRight: Radius.circular(8.r),
          ),
        ),
        child: InkWell(
          onTap: () => Get.toNamed(
            MyRouter.bookingDetail,
            arguments: widget.booking,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(
                                  0.5,
                                ),
                              ),
                            ),
                            color: ColorUtils.primaryColor.withOpacity(
                              0.1,
                            )),
                        child: Image.asset('assets/images/intro-4.png')),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 10.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: Get.width * 0.8,
                            child: Text(widget.booking.endPointMainText ?? "",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                            fontSize: 14.sp,
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
                                        widget.booking.duration == ''
                                            ? "0 phút"
                                            : widget.booking.duration
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
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
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                              bottom: 10.h,
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
                                    height: 30.r,
                                    width: 30.r,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.booking.authorId?.firstName ?? "",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.sw / 3,
                                      child: Text(
                                        DateFormat('HH:mm | dd/MM/yyyy').format(
                                            DateTime.parse(
                                                widget.booking.time ?? "")),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 14.sp,
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
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
