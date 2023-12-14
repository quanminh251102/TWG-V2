import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/utils/text_style_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';
import 'package:twg/ui/utils/handling_string_utils.dart';

class ComingApplyDialog extends StatelessWidget {
  final ApplyDto apply;
  final Function setBooking;

  const ComingApplyDialog({
    Key? key,
    required this.apply,
    required this.setBooking,
  }) : super(key: key);

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
              'Thông báo người muốn tham gia ?',
              style: TextStyleUtils.subHeadingBold,
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage(apply.applyer!.avatarUrl.toString()),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          apply.applyer!.firstName.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(apply.applyer!.phoneNumber.toString()),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(HandlingStringUtils.timeDistanceFromNow(
                        DateTime.parse(apply.createdAt.toString()))),
                  ],
                )
              ],
            ),
            if (apply.dealPrice == 0)
              Text(
                'Đồng ý giá : ${HandlingStringUtils.priceInPost_noType((apply.booking!.price.toString()).toString())}',
                style: const TextStyle(color: Colors.green),
              ),
            if (apply.dealPrice != 0)
              Text(
                'Deal giá : ${HandlingStringUtils.priceInPost_noType((apply.dealPrice.toString()).toString())}',
                style: const TextStyle(color: Colors.red),
              ),
            Text("Điểm đi: ${apply.booking!.startPointAddress}"),
            Text("Điểm đến: ${apply.booking!.endPointAddress}"),
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
                  text: 'Đóng',
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
                    setBooking(apply.booking as BookingDto);
                    Get.offNamed(MyRouter.applyInBooking);
                  },
                  height: 30.h,
                  width: 100.w,
                  text: 'Tiếp tục',
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
