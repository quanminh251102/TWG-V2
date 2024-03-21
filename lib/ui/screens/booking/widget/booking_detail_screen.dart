import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/dtos/review/review_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ireview_viewmodel.dart';
import 'package:twg/global/router.dart';

class BookingDetailScreen extends StatefulWidget {
  final BookingDto booking;
  const BookingDetailScreen({
    super.key,
    required this.booking,
  });

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  bool isNavigateChatRoom = false;
  bool isNavigateCreateApply = false;
  late IApplyViewModel _iApplyViewModel;
  late IBookingViewModel _iBookingViewModel;
  late IMessageViewModel _iMessageViewModel;
  late IChatRoomViewModel _iChatRoomViewModel;
  late IReviewViewModel _iReviewViewModel;
  bool isMyList = false;
  Color getStatusColor(int status) {
    switch (status) {
      case 5:
        return ColorUtils.primaryColor;
      case 4:
        return Colors.green;
      case 3:
        return Colors.grey;
      case 2:
        return Colors.red;
      case 1:
        return Colors.orange;
      default:
        return ColorUtils.primaryColor;
    }
  }

  String getStatus(int status) {
    BookingStatus bookingStatus =
        EnumHelper.getEnum(EnumMap.bookingStatus, status - 1);
    return EnumHelper.getDescription(EnumMap.bookingStatus, bookingStatus);
  }

  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iMessageViewModel = context.read<IMessageViewModel>();
    _iChatRoomViewModel = context.read<IChatRoomViewModel>();
    _iReviewViewModel = context.read<IReviewViewModel>();
    Future.delayed(Duration.zero, () async {
      await _iReviewViewModel.init();
    });
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết chuyến đi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Get.offNamed(MyRouter.myBooking);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              _iApplyViewModel.setBookingDto(widget.booking);
              Get.offNamed(MyRouter.applyInBooking);
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                ),
                child: Text(
                  'Danh sách',
                  style: TextStyle(
                    color: ColorUtils.primaryColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor.withOpacity(
                0.058,
              ),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  MyRouter.driverProfile,
                  arguments: widget.booking.authorId,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin:',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.booking.authorId?.firstName ?? "",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            widget.booking.authorId?.phoneNumber ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          widget.booking.authorId!.avatarUrl == avatarUrl
                              ? Lottie.asset(
                                  'assets/lottie/avatar.json',
                                  fit: BoxFit.fill,
                                  height: 80.h,
                                  width: 80.w,
                                )
                              : CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(widget
                                      .booking.authorId!.avatarUrl
                                      .toString()),
                                  backgroundColor: Colors.transparent,
                                ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Consumer<IReviewViewModel>(
                                builder: (context, vm, child) {
                                  List<int> numbers = [];
                                  List<ReviewDto> myReview = vm.reviews
                                      .where((element) =>
                                          element.receiver!.id ==
                                          widget.booking.authorId!.id)
                                      .toList();
                                  double average = 0;
                                  if (myReview.isNotEmpty) {
                                    numbers.addAll(
                                      myReview.map(
                                        (e) => e.star!,
                                      ),
                                    );
                                    int sum = numbers.reduce((a, b) => a + b);
                                    average = sum / numbers.length;
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 3.h,
                                      horizontal: 5.w,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          average.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: ColorUtils.primaryColor,
                                          size: 14.r,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor.withOpacity(
                0.058,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thanh toán: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cước phí: ',
                          style: TextStyle(
                            fontSize: 14.sp,
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        VietnameseMoneyFormatter().formatToVietnameseCurrency(
                          widget.booking.price.toString(),
                        ),
                        style: TextStyle(
                            fontSize: 14.sp, color: ColorUtils.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phí thương lượng: ',
                          style: TextStyle(
                            fontSize: 14.sp,
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        VietnameseMoneyFormatter().formatToVietnameseCurrency(
                          (widget.booking.price! * 0.1)
                              .toDouble()
                              .toInt()
                              .toString(),
                        ),
                        style: TextStyle(
                            fontSize: 14.sp, color: ColorUtils.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hình thức thanh toán: ',
                          style: TextStyle(
                            fontSize: 14.sp,
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Tiền mặt',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorUtils.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor.withOpacity(
                0.058,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Mã chuyến đi: ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.booking.id ?? "",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text('Thời gian: ',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      Text(widget.booking.time ?? "",
                          style: TextStyle(
                            fontSize: 16.sp,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Trạng thái: ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: widget.booking.status == 'available'
                                ? ColorUtils.primaryColor
                                : widget.booking.status == 'complete'
                                    ? Colors.green
                                    : Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            getStatus(widget.booking.status!).toUpperCase(),
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Nội dung: ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.booking.content ?? "",
                          style: TextStyle(
                            fontSize: 16.sp,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quãng đường: ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.booking.distance ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Thời gian di chuyển: ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.booking.duration ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Địa điểm: ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
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
                            width: 10.w,
                          ),
                          SizedBox(
                            width: 280.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.booking.startPointMainText ?? "",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(widget.booking.startPointAddress ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
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
                            width: 10.w,
                          ),
                          SizedBox(
                            width: 280.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.booking.endPointMainText ?? "",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                                Text(widget.booking.endPointAddress ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
