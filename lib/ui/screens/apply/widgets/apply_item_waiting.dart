import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/status_label.dart';

class ApplyItemWaiting extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  const ApplyItemWaiting({
    Key? key,
    required this.apply,
    required this.vm,
  }) : super(key: key);

  void waiting_accpected() async {
    await vm.updateApply(
      apply.id.toString(),
      UpdateApplyDto(
        state: 'accepted',
      ),
    );
  }

  void waiting_rejected() async {
    await vm.updateApply(
      apply.id.toString(),
      UpdateApplyDto(
        state: 'refuse',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatusLabel(
          width: 109,
          backgroundColor: Color(0xffEDF3FC),
          textColor: Color(0xff5386E4),
          text: 'Đang chờ',
        ),
        if (vm.isMyApplys == false)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  waiting_accpected();
                },
                child: const Text('Đồng ý'),
              ),
              ElevatedButton(
                onPressed: () {
                  waiting_rejected();
                },
                child: const Text('Từ chối'),
              ),
            ],
          ),
      ],
    );
  }
}
