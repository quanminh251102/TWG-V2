import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';

abstract class IBookingService {
  Future<List<BookingDto>?> getBookings({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? status,
    String? authorId,
  });
  int get total;
  Future<List<BookingDto>?> getMyBookings({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  });
  Future<bool> saveLocation(Predictions location);
  Future<bool> createBooking(BookingDto bookingDto);
}
