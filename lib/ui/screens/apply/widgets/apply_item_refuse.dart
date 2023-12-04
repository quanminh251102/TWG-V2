import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/status_label.dart';

class ApplyItemRefuse extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  const ApplyItemRefuse({
    Key? key,
    required this.apply,
    required this.vm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatusLabel(
          width: 80,
          backgroundColor: Color(0xffFFEDED),
          textColor: Color(0xffDC312D),
          text: 'Bị từ chối',
        ),
      ],
    );
  }
}
