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
        // Row(
        //   children: [
        //     Material(
        //       color: Color(0xffFFEDED),
        //       borderRadius: BorderRadius.circular(52),
        //       child: InkWell(
        //         onTap: () {},
        //         borderRadius: BorderRadius.circular(52),
        //         child: Container(
        //           width: 80,
        //           height: 39,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(52),
        //           ),
        //           alignment: Alignment.center,
        //           child: const Text(
        //             'Bị từ chối',
        //             style: TextStyle(
        //               fontSize: 13,
        //               fontWeight: FontWeight.bold,
        //               color: Color(0xffDC312D),
        //             ),
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
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
