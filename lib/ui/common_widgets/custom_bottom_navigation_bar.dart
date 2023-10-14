import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/common_widgets/confirm_login_dialog.dart';
import 'package:twg/ui/common_widgets/ripple_click_effect.dart';

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
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 67.h,
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
                },
                title: 'Chuyến đi',
                image: 'assets/icons/book.svg',
                isSelected: value == CustomNavigationBar.booking,
              ),
            ),
            SizedBox(
              width: 80.w,
            ),
            Expanded(
              child: _BottomBarItem(
                onTap: () {
                  if (locator<GlobalData>().currentUser != null) {
                    // Get.toNamed(MyRouter.order);
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
                    // Get.toNamed(
                    //   MyRouter.customerManagementTabbar,
                    //   arguments: true,
                    // );
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
            color:
                isSelected ? ColorUtils.primaryColor : const Color(0xFF494949),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            title,
            style: TextStyleUtils.footnoteSemiBold.copyWith(
              color: isSelected
                  ? ColorUtils.primaryColor
                  : const Color(0xFF494949),
            ),
          ),
        ],
      ),
    );
  }
}
