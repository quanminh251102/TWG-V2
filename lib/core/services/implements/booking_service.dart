import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/pagination/pagination_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class BookingService implements IBookingService {
  int _total = 0;
  @override
  int get total => _total;
  @override
  Future<List<BookingDto>?> getBookings({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? status,
    String? authorId,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getBookings(
          token: token,
          page: page,
          pageSize: pageSize,
          status: status,
          authorId: authorId);

      if (result.success) {
        _total = result.total ?? 0;
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
