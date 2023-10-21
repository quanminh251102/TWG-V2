import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/common_widgets/confirm_login_dialog.dart';
import 'package:twg/ui/screens/booking/widget/create_post_bottom_sheet.dart';

import '../../core/utils/color_utils.dart';
import '../../global/global_data.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Container(
        height: 86.r,
        width: 86.r,
        color: Colors.transparent,
        child: FloatingActionButton(
          backgroundColor: ColorUtils.primaryColor,
          onPressed: () {
            if (locator<GlobalData>().currentUser != null) {
              Get.bottomSheet(CreatePostSheet(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ));
            } else {
              Get.dialog(
                const ConfirmLoginDialog(),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopify_sharp,
                size: 36.r,
                color: Colors.white,
              ),
              Text(
                'Đăng bài',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0),
              ),
            ],
          ),
          // elevation: 5.0,
        ),
      ),
    );
  }
}
