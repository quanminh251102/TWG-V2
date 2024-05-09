import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';

abstract class IBookingService {
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
  });
  int get total;
  Future<List<BookingDto>?> getMyBookings({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  });
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
  });
  Future<bool> saveLocation(LocationDto location);
  Future<bool> createBooking(BookingDto bookingDto);
  Future<bool> saveBooking(String bookingId);
  Future<List<BookingDto>?> getRecommendBooking({
    String? token,
    String? type,
    double? startPointLat,
    double? startPointLong,
    double? endPointLat,
    double? endPointLong,
  });
}
