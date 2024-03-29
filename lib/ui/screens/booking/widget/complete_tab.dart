part of '../booking_screen.dart';

class _CompleteBookingTab extends StatefulWidget {
  @override
  State<_CompleteBookingTab> createState() => ___CompleteBookingTabState();
}

class ___CompleteBookingTabState extends State<_CompleteBookingTab> {
  late final ScrollController scrollController;
  late IBookingViewModel _iBookingViewModel;
  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    scrollController = ScrollController();
    Future.delayed(Duration.zero, () async {
      _iBookingViewModel.setIsMyList(false);
      await _iBookingViewModel.init(
        EnumHelper.getDescription(
          EnumMap.bookingStatus,
          BookingStatus.complete,
        ),
      );
      print('booking length :${_iBookingViewModel.bookings.length}');
    });
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          await _iBookingViewModel.getMoreBookings(
            EnumHelper.getDescription(
              EnumMap.bookingStatus,
              BookingStatus.complete,
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
