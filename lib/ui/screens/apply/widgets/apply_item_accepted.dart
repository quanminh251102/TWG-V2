import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/status_label.dart';

class ApplyItemAccepted extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  const ApplyItemAccepted({
    Key? key,
    required this.apply,
    required this.vm,
  }) : super(key: key);

  void accepted_starting() async {
    await vm.updateApply(
      apply.id.toString(),
      UpdateApplyDto(
        state: 'starting',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatusLabel(
          width: 120,
          backgroundColor: Color(0xffE8FDF2),
          textColor: Color(0xff0E9D57),
          text: 'Chấp nhận',
        ),
        if (vm.isMyApplys == false)
          Center(
            child: ElevatedButton(
              onPressed: () {
                accepted_starting();
              },
              child: const Text('Bắt đầu'),
            ),
          ),
      ],
    );
  }
}
