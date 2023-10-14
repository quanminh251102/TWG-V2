// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../booking_screen.dart';

class _AvailableBookingTab extends StatefulWidget {
  @override
  State<_AvailableBookingTab> createState() => ___AvailableBookingTabState();
}

class ___AvailableBookingTabState extends State<_AvailableBookingTab> {
  late final ScrollController scrollController;
  late IBookingViewModel _iBookingViewModel;
  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    scrollController = ScrollController();
    Future.delayed(Duration.zero, () async {
      await _iBookingViewModel.init(
        EnumHelper.getDescription(
          EnumMap.bookingStatusType,
          BookingStatusType.available,
        ),
      );
    });
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          await _iBookingViewModel.getMoreBookings(
            EnumHelper.getDescription(
              EnumMap.bookingStatusType,
              BookingStatusType.available,
            ),
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IBookingViewModel>(
      builder: (context, vm, child) {
        return ListBooking(
          bookings: vm.bookings,
        );
      },
    );
  }
}
