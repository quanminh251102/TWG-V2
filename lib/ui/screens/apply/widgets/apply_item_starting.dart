import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/status_label.dart';

class ApplyItemStarting extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  const ApplyItemStarting({
    Key? key,
    required this.apply,
    required this.vm,
  }) : super(key: key);

  void watch_map() {
    // appRouter.push(TrackingScreenRoute(apply: widget.apply));
  }

  void accepted_close() async {
    await vm.updateApply(
      apply.id.toString(),
      UpdateApplyDto(
        state: 'close',
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
          text: 'Đang thực hiện',
        ),
        if (vm.isMyApplys == false)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    watch_map();
                  },
                  child: const Text('Xem bản đồ')),
              const SizedBox(width: 50),
              ElevatedButton(
                  onPressed: () {
                    accepted_close();
                  },
                  child: const Text('Đóng chuyến đi')),
            ],
          ),
        if (vm.isMyApplys == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    watch_map();
                  },
                  child: const Text('Xem bản đồ')),
            ],
          ),
      ],
    );
  }
}
