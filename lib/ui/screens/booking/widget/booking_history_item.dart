import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/router.dart';

class BookingHistoryItem extends StatefulWidget {
  final BookingDto booking;
  const BookingHistoryItem({
    super.key,
    required this.booking,
  });

  @override
  State<BookingHistoryItem> createState() => _BookingHistoryItemState();
}

class _BookingHistoryItemState extends State<BookingHistoryItem> {
  bool isNavigateChatRoom = false;
  bool isNavigateCreateApply = false;
  late IApplyViewModel _iApplyViewModel;
  late IBookingViewModel _iBookingViewModel;

  bool isMyList = false;

  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    _iBookingViewModel = context.read<IBookingViewModel>();

    isMyList = _iBookingViewModel.isMyList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        MyRouter.bookingDetail,
        arguments: widget.booking,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.primaryColor.withOpacity(
              0.058,
            ),
            borderRadius: BorderRadius.circular(
              15.r,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: ColorUtils.primaryColor,
                      child: Icon(
                        Icons.motorcycle_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 320.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.booking.time ?? "",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
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
                                    widget.booking.status!.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cước phí: ',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              VietnameseMoneyFormatter()
                                  .formatToVietnameseCurrency(
                                widget.booking.price.toString(),
                              ),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorUtils.primaryColor),
                            ),
                          ],
                        )
                      ],
                    )
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
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(widget.booking.startPointAddress ?? "",
                                  overflow: TextOverflow.ellipsis, maxLines: 2),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
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
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2),
                              Text(widget.booking.endPointAddress ?? "",
                                  overflow: TextOverflow.ellipsis, maxLines: 2),
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
      ),
    );
  }
}
