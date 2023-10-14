import 'package:flutter/material.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/ui/screens/booking/widget/list_booking_item.dart';

class ListBooking extends StatelessWidget {
  final List<BookingDto> bookings;
  const ListBooking({
    Key? key,
    required this.bookings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListBookingItem(
          booking: bookings[index],
        );
      },
      itemCount: bookings.length,
    );
  }
}
