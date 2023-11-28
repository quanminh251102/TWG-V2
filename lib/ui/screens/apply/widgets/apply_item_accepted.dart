import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
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
    // setState(() {
    //   isLoading_accepted_start = true;
    // });
    // String result = await ApplyService.update(widget.apply._id, {
    //   "state": "starting",
    // });
    // if (result == "pass") {
    //   const snackBar = SnackBar(
    //     content: Text('Thành công'),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   widget.reload();
    // } else {
    //   const snackBar = SnackBar(
    //     content: Text('Bị lỗi'),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    // setState(() {
    //   isLoading_accepted_start = false;
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Material(
        //       color: const Color(0xffE8FDF2),
        //       borderRadius: BorderRadius.circular(52),
        //       child: InkWell(
        //         onTap: () {},
        //         borderRadius: BorderRadius.circular(52),
        //         child: Container(
        //           width: 120,
        //           height: 39,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(52),
        //           ),
        //           alignment: Alignment.center,
        //           child: const Text(
        //             'Chấp nhận',
        //             style: TextStyle(
        //               fontSize: 13,
        //               fontWeight: FontWeight.bold,
        //               color: Color(0xff0E9D57),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
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
