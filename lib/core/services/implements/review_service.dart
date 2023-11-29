import 'package:twg/core/dtos/review/review_dto.dart';
import 'package:twg/core/dtos/review/create_review_dto.dart';
import 'package:twg/core/services/interfaces/ireview_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class ReviewService implements IReviewService {
  int _total = 0;
  @override
  int get total => _total;

  @override
  Future<List<ReviewDto>?> getReviews({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getReviews(
        token: token,
        page: page,
        pageSize: pageSize,
      );

      if (result.success) {
        _total = result.total ?? 0;
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<String> createReview(
    CreateReviewDto value,
  ) async {
    String? token = await TokenUtils.getToken();
    var resText = '';
    try {
      var result = await getRestClient().createReview(
        token.toString(),
        value,
      );

      if (result.success) {
        resText = 'Thành công';
      } else {
        resText = 'Thất bại';
      }
    } on Exception catch (e) {
      resText = 'Thất bại';
      print(e);
    }
    return resText;
  }
}
