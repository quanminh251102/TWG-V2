import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/review/create_review_dto.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ireview_viewmodel.dart';
import 'package:twg/ui/screens/apply/widgets/status_label.dart';

class ApplyItemClose extends StatelessWidget {
  final ApplyDto apply;
  final IApplyViewModel vm;
  final IReviewViewModel? rvm;
  const ApplyItemClose({
    Key? key,
    required this.apply,
    required this.vm,
    this.rvm,
  }) : super(key: key);
  void close_review(context) async {
    final dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Đánh giá hành khách',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        'Hãy chọn số sao và viết ghi chú nếu bạn muốn',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      // image: const FlutterLogo(size: 100),
      image: Image.asset('assets/images/reviews.jpg'),
      submitButtonText: 'Gửi',
      commentHint: 'Ghi chú',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {}

        await rvm!.createReview(CreateReviewDto(
          applyId: apply.id,
          receiverId: apply.applyer!.id,
          note: response.comment,
          star: response.rating.toInt(),
        ));
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => dialog,
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
          text: 'Đã hoàn thành',
        ),
        if (vm.isMyApplys == false)
          Center(
            child: ElevatedButton(
                onPressed: () {
                  close_review(context);
                },
                child: const Text('Đánh giá')),
          ),
      ],
    );
  }
}
