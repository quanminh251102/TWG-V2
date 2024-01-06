// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/router.dart';

class ListBookingItem extends StatefulWidget {
  final BookingDto booking;
  const ListBookingItem({
    Key? key,
    required this.booking,
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
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtils.primaryColor.withOpacity(
            0.1,
          ),
          borderRadius: BorderRadius.circular(
            15.r,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      MyRouter.driverProfile,
                      arguments: widget.booking.authorId,
                    );
                  },
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            widget.booking.authorId?.avatarUrl ?? "",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.booking.authorId?.lastName ?? "",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.booking.authorId?.phoneNumber ?? "",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.booking.bookingType ?? "",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: widget.booking.status == 'available'
                                ? ColorUtils.primaryColor
                                : widget.booking.status == 'complete'
                                    ? Colors.green
                                    : Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.booking.status!.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))
                  ]),
                ),
              ),
              ExpansionTile(
                title: const Text('Chi tiết'),
                children: [
                  Text(widget.booking.content ?? "",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/distance.svg",
                              height: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.booking.distance ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/clock.svg",
                              height: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.booking.duration ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/wallet.svg",
                              height: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              VietnameseMoneyFormatter()
                                  .formatToVietnameseCurrency(
                                widget.booking.price.toString(),
                              ),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      children: [
                        const Text(
                          'Thời gian: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        Text(
                          widget.booking.time ?? "",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40.w,
                              child: lottie.Lottie.asset(
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
                                    style: const TextStyle(
                                        fontSize: 16,
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
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40.w,
                              child: lottie.Lottie.asset(
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
                                      style: const TextStyle(
                                          fontSize: 16,
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
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (isMyList)
                    ElevatedButton(
                      onPressed: () {
                        _iApplyViewModel.setBookingDto(widget.booking);
                        Get.offNamed(MyRouter.applyInBooking);
                      },
                      child: const Text('Danh sách'),
                    ),
                  if (isMyList == false)
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
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
