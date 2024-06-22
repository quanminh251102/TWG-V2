import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/action_button.dart';
import 'package:twg/ui/screens/profile_and_settings/widget/animated_avatar.dart';

class DriverProfileScreen extends StatefulWidget {
  final AccountDto accountDto;
  const DriverProfileScreen({
    Key? key,
    required this.accountDto,
  }) : super(key: key);
  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  bool isNavigateChatRoom = false;
  bool isNavigateCreateApply = false;
  List<dynamic> reviews = [];
  List<dynamic> bookings = [];
  double rating = 0;
  List<dynamic> completeBooking = [];
  bool isLoading_getMyBook = false;
  late IChatRoomViewModel _iChatRoomViewModel;
  late IMessageViewModel _iMessageViewModel;
  void navigateChatRoom(BuildContext context) async {
    var value = await _iChatRoomViewModel.createChatRoom(
      CreateChatRoomDto(userId: widget.accountDto.id),
    );
    if (value != null) {
      _iMessageViewModel.setCurrentChatRoom(value);
      Get.offNamed(MyRouter.message);
    }
  }

  void init() {
    setState(() {
      isLoading_getMyBook = true;
    });
    try {
      // bookings = await BookingService.getBookingWithId(widget.accountDto.id.toString());
      // completeBooking =
      //     await BookingService.getMyCompleteBooking(author!.id.toString());
      // reviews = await ReviewService.getReviewWithUserId(appUser.id);
      // double sumRating = 0;
      // for (var review in reviews) {
      //   sumRating += review["review_star"];
      // }
      // rating = sumRating / reviews.length;
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading_getMyBook = false;
    });
  }

  @override
  void initState() {
    _iChatRoomViewModel = context.read<IChatRoomViewModel>();
    _iMessageViewModel = context.read<IMessageViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Thông tin tài xế',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            AnimatedAvatar(
              avatarUrl: widget.accountDto.avatarUrl.toString(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              widget.accountDto.firstName ?? "",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.accountDto.phoneNumber ?? "",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            radius: 25,
                            child: const Icon(
                              Icons.star,
                              color: ColorUtils.primaryColor,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Text(
                            'Đánh giá',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            radius: 25,
                            child: const Icon(
                              Icons.book,
                              color: ColorUtils.primaryColor,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            bookings.length.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Bài đăng',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            radius: 25,
                            child: const Icon(
                              Icons.car_rental,
                              color: ColorUtils.primaryColor,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            completeBooking.length.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Chuyến đi',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Địa chỉ:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${widget.accountDto.locationMainText}, ${widget.accountDto.locationAddress}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Email: ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.accountDto.email ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    navigateChatRoom(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    radius: 30,
                    child: const Icon(
                      Icons.message,
                      color: ColorUtils.primaryColor,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    radius: 30,
                    child: const Icon(
                      Icons.call,
                      color: ColorUtils.primaryColor,
                      size: 35,
                    ),
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
