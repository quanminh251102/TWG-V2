// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../booking_screen.dart';

class _ForYouBookingTab extends StatefulWidget {
  @override
  State<_ForYouBookingTab> createState() => ___ForYouBookingTabState();
}

class ___ForYouBookingTabState extends State<_ForYouBookingTab> {
  late final ScrollController scrollController;
  late IBookingViewModel _iBookingViewModel;
  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    scrollController = ScrollController();

    Future.delayed(Duration.zero, () async {
      _iBookingViewModel.setIsMyList(false);
      // await _iBookingViewModel.init(
      //   EnumHelper.getDescription(
      //     EnumMap.bookingStatus,
      //     BookingStatus.available,
      //   ),
      // );
    });
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          await _iBookingViewModel.getMoreBookings(
            status: EnumHelper.getValue(
              EnumMap.bookingStatus,
              BookingStatus.available,
            ),
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Dành cho bạn');
  }
}
