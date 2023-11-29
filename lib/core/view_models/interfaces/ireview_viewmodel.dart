import 'package:flutter/material.dart';
import 'package:twg/core/dtos/review/create_review_dto.dart';
import 'package:twg/core/dtos/review/review_dto.dart';

abstract class IReviewViewModel implements ChangeNotifier {
  List<ReviewDto> get reviews;
  bool get isLoading;
  Future<void> init();
  Future<void> getMoreReviews();
  Future<void> createReview(CreateReviewDto value);

  List<ReviewDto> get reviewsAfterFilter;
  void setName(String value);
}
