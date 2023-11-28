import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_accepted.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_close.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_refuse.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_starting.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item_waiting.dart';
import 'package:twg/ui/utils/handling_string_utils.dart';

class ApplyItem extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  const ApplyItem({
    Key? key,
    required this.apply,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      childPadding: 12,
      child: Column(
        children: [
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
                  Text(
                      'Giá : ${HandlingStringUtils.priceInPost_noType((apply.booking!.price.toString()).toString())}'),
                  Text(HandlingStringUtils.timeDistanceFromNow(
                      DateTime.parse(apply.createdAt.toString()))),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          if (apply.state == "waiting") ApplyItemWaiting(apply: apply, vm: vm),
          if (apply.state == "accepted")
            ApplyItemAccepted(apply: apply, vm: vm),
          if (apply.state == "starting")
            ApplyItemStarting(apply: apply, vm: vm),
          if (apply.state == "close") ApplyItemClose(apply: apply, vm: vm),
          if (apply.state == "refuse") ApplyItemRefuse(apply: apply, vm: vm),
        ],
      ),
    );
  }
}
