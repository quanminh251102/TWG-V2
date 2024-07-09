import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
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
        elevation: 0,
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
                            widget.accountDto.reviewNum != null
                                ? widget.accountDto.reviewNum.toString()
                                : '0',
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
                            widget.accountDto.bookingNum != null
                                ? widget.accountDto.bookingNum.toString()
                                : '0',
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
                            widget.accountDto.applyNum != null
                                ? widget.accountDto.applyNum.toString()
                                : '0',
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
                            'Thành viên từ:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            DateFormat('HH:mm | dd/MM/yyyy')
                                .format(DateTime.parse(
                              widget.accountDto.createdAt ?? "",
                            )),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(
                          0.2,
                        ),
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Giới tính:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.accountDto.gender == 'female' ? 'Nữ' : 'Nam',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(
                          0.2,
                        ),
                        thickness: 1,
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
                  child: Container(
                    width: Get.size.width * 0.35,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        30.r,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        8.r,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.message,
                            color: ColorUtils.primaryColor,
                            size: 25.r,
                          ),
                          Text('Nhắn tin',
                              style: TextStyle(
                                fontSize: 15.sp,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    navigateChatRoom(context);
                  },
                  child: Container(
                    width: Get.size.width * 0.35,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: ColorUtils.primaryColor,
                      borderRadius: BorderRadius.circular(
                        30.r,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        8.r,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 25.r,
                          ),
                          Text(
                            'Gọi điện',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
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
