import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
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
    // setState(() {
    //   isLoading_waiting_accpected = true;
    // });
    // //await Future.delayed(Duration(seconds: 2));
    // String result = await ApplyService.update(widget.apply._id, {
    //   "state": "accepted",
    // });
    // if (result == "pass") {
    //   widget.reload();
    // } else {
    //   const snackBar = SnackBar(
    //     content: Text('Bị lỗii'),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    // setState(() {
    //   isLoading_waiting_accpected = false;
    // });
  }

  void waiting_rejected() async {
    // setState(() {
    //   isLoading_waiting_rejected = true;
    // });
    // // await Future.delayed(Duration(seconds: 2));
    // String result = await ApplyService.update(widget.apply._id, {
    //   "state": "refuse",
    // });
    // if (result == "pass") {
    //   widget.reload();
    // } else {
    //   const snackBar = SnackBar(
    //     content: Text('Bị lỗi'),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    // setState(() {
    //   isLoading_waiting_rejected = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Material(
        //   color: const Color(0xffEDF3FC),
        //   borderRadius: BorderRadius.circular(52),
        //   child: InkWell(
        //     onTap: () {},
        //     borderRadius: BorderRadius.circular(52),
        //     child: Container(
        //       width: 109,
        //       height: 39,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(52),
        //       ),
        //       alignment: Alignment.center,
        //       child: const Text(
        //         'Đang chờ',
        //         style: TextStyle(
        //           fontSize: 13,
        //           fontWeight: FontWeight.bold,
        //           color: Color(0xff5386E4),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
