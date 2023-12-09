import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/common_widgets/confirm_login_dialog.dart';
import 'package:twg/ui/common_widgets/ripple_click_effect.dart';
import 'package:twg/ui/screens/booking/widget/create_post_bottom_sheet.dart';

import '../../core/utils/color_utils.dart';
import '../../core/utils/enum.dart';
import '../../core/utils/text_style_utils.dart';
import '../../global/router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final CustomNavigationBar value;
  const CustomBottomNavigationBar({Key? key, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 30.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      height: 80.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _BottomBarItem(
              onTap: () => Get.toNamed(MyRouter.home),
              title: 'Trang chủ',
              image: 'assets/icons/home.svg',
              isSelected: value == CustomNavigationBar.home,
            ),
          ),
          Expanded(
            child: _BottomBarItem(
              onTap: () {
                // Get.toNamed(MyRouter., arguments: -1)
                Get.toNamed(MyRouter.booking);
              },
              title: 'Chuyến đi',
              image: 'assets/icons/book.svg',
              isSelected: value == CustomNavigationBar.booking,
            ),
          ),
          InkWell(
            onTap: () {
              if (locator<GlobalData>().currentUser != null) {
                Get.bottomSheet(
                  const CreatePostSheet(),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                );
              } else {
                Get.dialog(
                  const ConfirmLoginDialog(),
                );
              }
            },
            child: Container(
              width: 100.w,
              height: 60.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorUtils.primaryColor,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.r,
              ),
            ),
          ),
          Expanded(
            child: _BottomBarItem(
              onTap: () {
                if (locator<GlobalData>().currentUser != null) {
                  Get.toNamed(MyRouter.chatRoom);
                } else {
                  Get.dialog(
                    const ConfirmLoginDialog(),
                  );
                }
              },
              title: 'Trò chuyện',
              image: 'assets/icons/chat.svg',
              isSelected: value == CustomNavigationBar.chat,
            ),
          ),
          Expanded(
            child: _BottomBarItem(
              onTap: () {
                if (locator<GlobalData>().currentUser != null) {
                  Get.toNamed(
                    MyRouter.profile,
                    arguments: true,
                  );
                } else {
                  Get.dialog(
                    const ConfirmLoginDialog(),
                  );
                }
              },
              title: 'Cá nhân',
              image: 'assets/icons/group-people.svg',
              isSelected: value == CustomNavigationBar.account,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String image;
  final bool isSelected;
  const _BottomBarItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.image,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleClickEffect(
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.cover,
            color: isSelected
                ? ColorUtils.primaryColor
                : const Color(
                    0xFF494949,
                  ),
          ),
        ],
      ),
    );
  }
}
