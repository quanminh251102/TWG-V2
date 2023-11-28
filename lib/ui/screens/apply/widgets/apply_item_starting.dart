import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
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
    // setState(() {
    //   isLoading_accepted_close = true;
    // });
    // // await Future.delayed(Duration(seconds: 2));
    // String result = await ApplyService.update(widget.apply._id, {
    //   "state": "close",
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
    //   isLoading_accepted_close = false;
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
        //           width: 150,
        //           height: 39,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(52),
        //           ),
        //           alignment: Alignment.center,
        //           child: const Text(
        //             'Đang thực hiện',
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
