import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/goongs/save_place_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/utils/loading_dialog_utils.dart';

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

  @override
  Future<List<BookingDto>?> getMyBookings({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getMyBookings(
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
  Future<bool> saveLocation(Predictions location) async {
    var token = await TokenUtils.getToken();
    if (token != null) {
      LoadingDialogUtils.showLoading();
      try {
        var result = await getRestClient().saveLocation(
            token: token,
            model: SavePlaceDto(
              placeName: location.description!.split(',')[0].toString(),
              placeDescription: location.description!
                  .split(', ')
                  .sublist(1)
                  .join(', ')
                  .toString(),
              placeId: location.placeId,
            ));
        if (result.success) {
          return true;
        }
      } catch (e) {
        print(e);
      } finally {
        LoadingDialogUtils.hideLoading();
      }
    }
    return false;
  }

  @override
  Future<bool> createBooking(BookingDto bookingDto) async {
    var token = await TokenUtils.getToken();
    if (token != null) {
      print(bookingDto.toJson().toString());
      LoadingDialogUtils.showLoading();
      try {
        var result = await getRestClient().createBooking(
          token: token,
          model: bookingDto,
        );
        if (result.success) {
          return true;
        }
      } catch (e) {
        print(e);
      } finally {
        LoadingDialogUtils.hideLoading();
      }
    }
    return false;
  }
}
