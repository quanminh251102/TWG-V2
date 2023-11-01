import 'package:twg/core/dtos/booking/booking_dto.dart';

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
}
