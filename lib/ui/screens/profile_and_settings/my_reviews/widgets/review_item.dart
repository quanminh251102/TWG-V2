import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:twg/core/dtos/review/review_dto.dart';

class ReviewItem extends StatelessWidget {
  final ReviewDto review;
  const ReviewItem({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      childPadding: 12,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage(review.creater!.avatarUrl.toString()),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: review.star!.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Text('02/06/2023'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${review.creater!.firstName}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('${review.note}')
        ],
      ),
    );
  }
}
