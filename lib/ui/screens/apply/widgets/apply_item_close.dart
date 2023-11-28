import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/status_label.dart';

class ApplyItemClose extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  const ApplyItemClose({
    Key? key,
    required this.apply,
    required this.vm,
  }) : super(key: key);
  void close_review() async {
    // final _dialog = RatingDialog(
    //   initialRating: 1.0,
    //   // your app's name?
    //   title: const Text(
    //     'Đánh giá người đi chung',
    //     textAlign: TextAlign.center,
    //     style: const TextStyle(
    //       fontSize: 25,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   // encourage your user to leave a high rating?
    //   message: const Text(
    //     'Hãy chọn số sao và viết ghi chú nếu bạn muốn',
    //     textAlign: TextAlign.center,
    //     style: const TextStyle(fontSize: 15),
    //   ),
    //   // your app's logo?
    //   // image: const FlutterLogo(size: 100),
    //   image: Image.asset('assets/images/reviews.jpg'),
    //   submitButtonText: 'Gửi',
    //   commentHint: 'Ghi chú',
    //   onCancelled: () => print('cancelled'),
    //   onSubmitted: (response) async {
    //     print('rating: ${response.rating}, comment: ${response.comment}');

    //     // TODO: add your own logic
    //     if (response.rating < 3.0) {
    //       // send their comments to your email or anywhere you wish
    //       // ask the user to contact you instead of leaving a bad review
    //     } else {}

    //     Map<String, dynamic> _body = {
    //       "creater_id": appUser.id,
    //       "receiver_id": widget.apply.applyer._id,
    //       "apply_id": widget.apply._id,
    //       "review_note": (response.comment == "") ? " " : response.comment,
    //       "review_star": "${response.rating}"
    //     };

    //     String result = await ReviewService.createReview(_body);

    //     if (result == "pass") {
    //       const snackBar = SnackBar(
    //         content: Text('Thành công'),
    //       );
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     } else {
    //       const snackBar = SnackBar(
    //         content: Text('Bị lỗi'),
    //       );
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }
    //   },
    // );

    // // show the dialog
    // showDialog(
    //   context: context,
    //   barrierDismissible: true, // set to false if you want to force a rating
    //   builder: (context) => _dialog,
    // );
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
        //             'Đã hoàn thành',
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
          text: 'Đã hoàn thành',
        ),
        if (vm.isMyApplys == false)
          Center(
            child: ElevatedButton(
                onPressed: () {
                  close_review();
                },
                child: const Text('Đánh giá')),
          ),
      ],
    );
  }
}
