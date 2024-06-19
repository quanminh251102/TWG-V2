import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/utils/token_utils.dart';
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
    int? status,
    bool? isFavorite,
    bool? isMine,
    String? authorId,
    String? keyword,
    String? bookingType,
    int? minPrice,
    int? maxPrice,
    String? startAddress,
    String? endAddress,
    String? startTime,
    String? endTime,
    String? id,
  }) async {
    String? token = await TokenUtils.getToken();
    // LoadingDialogUtils.showLoading();
    try {
      var result = await getRestClient().getBookings(
        token: token,
        page: page,
        pageSize: pageSize,
        status: status,
        isFavorite: isFavorite,
        isMine: isMine,
        authorId: authorId,
        keyword: keyword,
        bookingType: bookingType,
        minPrice: minPrice,
        maxPrice: maxPrice,
        startAddress: startAddress,
        endAddress: endAddress,
        startTime: startTime,
        endTime: endTime,
      );
      // LoadingDialogUtils.hideLoading();
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
  Future<List<BookingDto>?> getSaveBookings({
    String? token,
    int? page,
    int? pageSize,
    int? status,
    String? authorId,
    String? keyword,
    String? bookingType,
    int? minPrice,
    int? maxPrice,
    String? startAddress,
    String? endAddress,
    String? startTime,
    String? endTime,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getSaveBookings(
        token: token,
        page: page,
        pageSize: pageSize,
        // status: status,
        // authorId: authorId,
        // keyword: keyword,
        // bookingType: bookingType,
        // minPrice: minPrice,
        // maxPrice: maxPrice,
        // startAddress: startAddress,
        // endAddress: endAddress,
        // startTime: startTime,
        // endTime: endTime,
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
  Future<List<BookingDto>?> getRecommendBooking({
    String? token,
    String? type,
    double? startPointLat,
    double? startPointLong,
    double? endPointLat,
    double? endPointLong,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getRecommendBooking(
        token: token,
        type: type,
        startPointLat: startPointLat,
        startPointLong: startPointLong,
        endPointLat: endPointLat,
        endPointLong: endPointLong,
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
  Future<bool> saveLocation(LocationDto location) async {
    var token = await TokenUtils.getToken();
    if (token != null) {
      LoadingDialogUtils.showLoading();
      try {
        var result =
            await getRestClient().saveLocation(token: token, model: location);
        if (result.success) {
          EasyLoading.showSuccess('Lưu địa chỉ thành công!');
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

  @override
  Future<bool> saveBooking(String bookingId) async {
    var token = await TokenUtils.getToken();
    if (token != null) {
      // LoadingDialogUtils.showLoading();
      try {
        var result = await getRestClient().saveBooking(
          token: token,
          id: bookingId,
        );
        if (result.success) {
          EasyLoading.showSuccess('Lưu bài đăng thành công!');
          return true;
        }
      } catch (e) {
        print(e);
      } finally {}
    }
    return false;
  }
}
