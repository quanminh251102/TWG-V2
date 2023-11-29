import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
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
    return CustomCard(
      childPadding: 12,
      child: Column(
        children: [
          // user is the one who create booking
          if (!vm.isMyApplys)
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
                    Text(HandlingStringUtils.timeDistanceFromNow(
                        DateTime.parse(apply.createdAt.toString()))),
                  ],
                )
              ],
            ),
          // user is applyer
          if (vm.isMyApplys) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          apply.booking!.authorId!.avatarUrl.toString()),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(width: 12),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        'Giá : ${HandlingStringUtils.priceInPost_noType((apply.booking!.price).toString())}'),
                    Text(HandlingStringUtils.timeDistanceFromNow(
                        DateTime.parse(apply.createdAt.toString()))),
                  ],
                )
              ],
            ),
            if (apply.dealPrice == 0)
              Text(
                'Bạn đồng ý giá : ${HandlingStringUtils.priceInPost_noType((apply.booking!.price.toString()).toString())}',
                style: const TextStyle(color: Colors.green),
              ),
            if (apply.dealPrice != 0)
              Text(
                'Bạn đã deal giá : ${HandlingStringUtils.priceInPost_noType((apply.dealPrice.toString()).toString())}',
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 8),
            const Text(
              "Thông tin chuyến đi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Điểm đi: ${apply.booking!.startPointAddress}"),
            Text("Điểm đến: ${apply.booking!.endPointAddress}"),
          ],

          const SizedBox(height: 8),
          if (apply.state == "waiting") ApplyItemWaiting(apply: apply, vm: vm),
          if (apply.state == "accepted")
            ApplyItemAccepted(apply: apply, vm: vm),
          if (apply.state == "starting")
            ApplyItemStarting(apply: apply, vm: vm),
          if (apply.state == "close")
            ApplyItemClose(apply: apply, vm: vm, rvm: rvm),
          if (apply.state == "refuse") ApplyItemRefuse(apply: apply, vm: vm),
        ],
      ),
    );
  }
}
