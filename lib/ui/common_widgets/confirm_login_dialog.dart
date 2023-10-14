import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:twg/core/utils/text_style_utils.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';

class ConfirmLoginDialog extends StatelessWidget {
  const ConfirmLoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thông báo',
              style: TextStyleUtils.subHeadingBold,
            ),
            const Divider(
              thickness: 1,
            ),
            Text(
              'Vui lòng đăng nhập?',
              style: TextStyleUtils.subHeading2,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () => Get.back(),
                  height: 30.h,
                  width: 100.w,
                  text: 'Huỷ',
                  bgColor: Colors.grey,
                  textStyle: TextStyleUtils.subHeading2.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomButton(
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      MyRouter.signIn,
                    );
                  },
                  height: 30.h,
                  width: 100.w,
                  text: 'Xác nhận',
                  textStyle: TextStyleUtils.subHeading2.copyWith(
                    color: Colors.white,
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
