import 'package:twg/core/dtos/review/review_dto.dart';
import 'package:twg/core/dtos/review/create_review_dto.dart';

abstract class IReviewService {
  Future<List<ReviewDto>?> getReviews({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  });
  int get total;
  Future<String> createReview(CreateReviewDto value);
}
