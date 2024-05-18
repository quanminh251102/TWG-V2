// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/animation/ani_bottom_sheet.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';

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
    return SpringSlideTransition(
      child: Container(
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
                      icon: const Icon(
                        Icons.motorcycle,
                        color: Colors.white,
                      ),
                      isSelected: selectedIndex == 0,
                      onTap: () => selectOption(0),
                    ),
                    PostOptionItem(
                      title: 'Tìm hành khách',
                      description:
                          'Đăng bài để Tìm hành khách chia sẻ chuyến đi.',
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
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
                    context.read<IBookingViewModel>().updateBookingType(
                          selectedIndex == 0 ? 'Tìm tài xế' : 'Tìm hành khách',
                        );
                    Get.toNamed(
                      MyRouter.pickPlaceMap,
                    );
                  },
                  height: 40.h,
                  width: double.infinity,
                  text: 'Tiếp tục',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class PostOptionItem extends StatelessWidget {
  final String title;
  final String description;
  final Icon icon;
  final bool isSelected;
  final Function()? onTap;
  const PostOptionItem({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
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
                    child: icon,
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
                backgroundColor:
                    isSelected ? ColorUtils.primaryColor : Colors.white,
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
