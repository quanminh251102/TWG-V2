import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ireview_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_accepted.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_close.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_refuse.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_starting.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_waiting.dart';
import 'package:twg/ui/utils/handling_string_utils.dart';

class ApplyItem extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  final IReviewViewModel? rvm;
  const ApplyItem({
    Key? key,
    required this.apply,
    required this.vm,
    this.rvm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorUtils.primaryColor.withOpacity(
          0.058,
        ),
        borderRadius: BorderRadius.circular(
          15.r,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!vm.isMyApplys)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          apply.applyer!.avatarUrl == avatarUrl
                              ? Lottie.asset(
                                  'assets/lottie/avatar.json',
                                  fit: BoxFit.fill,
                                  height: 80.h,
                                  width: 80.w,
                                )
                              : CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(apply
                                      .booking!.authorId!.avatarUrl
                                      .toString()),
                                  backgroundColor: Colors.transparent,
                                ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apply.applyer!.firstName.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(apply.applyer!.phoneNumber ?? ""),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            HandlingStringUtils.timeDistanceFromNow(
                                DateTime.parse(apply.createdAt.toString())),
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Thông tin chuyến đi:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cước phí: ',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            apply.booking!.price.toString(),
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorUtils.primaryColor),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              if (apply.dealPrice == 0)
                                Text(
                                  'Đồng ý giá : ${HandlingStringUtils.priceInPost_noType((apply.booking!.price.toString()).toString())}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              if (apply.dealPrice != 0)
                                Text(
                                  'Giá thương lượng : ${HandlingStringUtils.priceInPost_noType((apply.dealPrice.toString()).toString())}',
                                  style: const TextStyle(color: Colors.red),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text('Thời gian: ',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            DateFormat('HH:mm | dd/MM/yyyy')
                                .format(DateTime.parse(
                              apply.booking?.time ?? "",
                            )),
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: Lottie.asset(
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
                                  apply.booking?.startPointMainText ?? "",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(apply.booking?.startPointAddress ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: Lottie.asset(
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
                                Text(apply.booking?.endPointMainText ?? "",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                                Text(apply.booking?.endPointAddress ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),

            // user is applyer
            if (vm.isMyApplys) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      apply.booking!.authorId!.avatarUrl == avatarUrl
                          ? Lottie.asset(
                              'assets/lottie/avatar.json',
                              fit: BoxFit.fill,
                              height: 80.h,
                              width: 80.w,
                            )
                          : CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(apply
                                  .booking!.authorId!.avatarUrl
                                  .toString()),
                              backgroundColor: Colors.transparent,
                            ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apply.booking!.authorId!.firstName.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(apply.booking!.authorId!.phoneNumber.toString()),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        HandlingStringUtils.timeDistanceFromNow(
                            DateTime.parse(apply.createdAt.toString())),
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Thông tin chuyến đi:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cước phí: ',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      Text(
                        apply.booking!.price != null
                            ? VietnameseMoneyFormatter()
                                .formatToVietnameseCurrency(
                                apply.booking!.price!.round().toString(),
                              )
                            : '0 đ',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorUtils.primaryColor),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          if (apply.dealPrice == 0)
                            Text(
                              'Bạn đồng ý giá : ${HandlingStringUtils.priceInPost_noType((apply.booking!.price.toString()).toString())}',
                              style: const TextStyle(color: Colors.green),
                            ),
                          if (apply.dealPrice != 0)
                            Text(
                              'Bạn đã Giá thương lượng : ${HandlingStringUtils.priceInPost_noType((apply.dealPrice.toString()).toString())}',
                              style: const TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text('Thời gian: ',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      Text(
                        DateFormat('HH:mm | dd/MM/yyyy').format(DateTime.parse(
                          apply.booking?.time ?? "",
                        )),
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Divider(
                  color: Colors.grey.withOpacity(0.2),
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40.w,
                        child: Lottie.asset(
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
                              apply.booking?.startPointMainText ?? "",
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(apply.booking?.startPointAddress ?? "",
                                overflow: TextOverflow.ellipsis, maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40.w,
                        child: Lottie.asset(
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
                            Text(apply.booking?.endPointMainText ?? "",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                            Text(apply.booking?.endPointAddress ?? "",
                                overflow: TextOverflow.ellipsis, maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
            SizedBox(
              height: 10.h,
            ),
            if (apply.state == "waiting")
              Center(child: ApplyItemWaiting(apply: apply, vm: vm)),
            if (apply.state == "accepted")
              Center(child: ApplyItemAccepted(apply: apply, vm: vm)),
            if (apply.state == "starting")
              Center(child: ApplyItemStarting(apply: apply, vm: vm)),
            if (apply.state == "close")
              Center(child: ApplyItemClose(apply: apply, vm: vm, rvm: rvm)),
            if (apply.state == "refuse")
              Center(child: ApplyItemRefuse(apply: apply, vm: vm)),
          ],
        ),
      ),
    );
  }
}
