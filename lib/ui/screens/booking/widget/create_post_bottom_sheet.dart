// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';
import 'package:twg/ui/screens/booking/add_booking.dart';

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  int selectedIndex = 0;
  void selectOption(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.all(
        10.r,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 30.h,
                    left: 10.w,
                  ),
                  child: SizedBox(
                    width: 300.w,
                    child: Text(
                      'Bạn muốn đăng bài cho chuyến đi: '.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
              ),
              child: Divider(
                color: Colors.black,
                height: 5.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              child: Column(
                children: [
                  PostOptionItem(
                    title: 'Tìm tài xế',
                    description:
                        'Đăng bài để tìm cho bạn một tài xế thích hợp.',
                    image: 'assets/icons/moto.svg',
                    isSelected: selectedIndex == 0,
                    onTap: () => selectOption(0),
                  ),
                  PostOptionItem(
                    title: 'Tìm hành khách',
                    description:
                        'Đăng bài để tìm hành khách chia sẻ chuyến đi.',
                    image: 'assets/icons/person.svg',
                    isSelected: selectedIndex == 1,
                    onTap: () => selectOption(1),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              child: CustomButton(
                onTap: () {
                  Get.toNamed(
                    MyRouter.addBooking,
                    arguments: selectedIndex == 0
                        ? BookingType.findDriver
                        : BookingType.findPassenger,
                  );
                },
                height: 40.h,
                width: double.infinity,
                text: 'Tiếp tục',
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ]),
    );
  }
}

class PostOptionItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isSelected;
  final Function()? onTap;
  const PostOptionItem({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        padding: EdgeInsets.only(
          top: 16.h,
          bottom: 8.h,
          left: 16.w,
          right: 16.w,
        ),
        decoration: BoxDecoration(
          color: ColorUtils.lightPrimaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 20.w,
              ),
              child: ClipOval(
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorUtils.primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: SvgPicture.asset(
                      image,
                      width: 30.r,
                      height: 30.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 260.w,
                    child: Text(
                      description,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black.withOpacity(0.8)),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: onTap,
              child: CircleAvatar(
                radius: 14.r,
                backgroundColor: isSelected
                    ? const Color.fromARGB(255, 223, 157, 3)
                    : Colors.white,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
