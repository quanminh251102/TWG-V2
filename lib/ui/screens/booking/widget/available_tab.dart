// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../booking_screen.dart';

class _AvailableBookingTab extends StatefulWidget {
  final AnimationController animationController;
  final Function(double scrollOffset) scrollCallback;
  const _AvailableBookingTab({
    Key? key,
    required this.animationController,
    required this.scrollCallback,
  }) : super(key: key);

  @override
  State<_AvailableBookingTab> createState() => ___AvailableBookingTabState();
}

class ___AvailableBookingTabState extends State<_AvailableBookingTab> {
  late IBookingViewModel _iBookingViewModel;
  late ScrollController scrollController;
  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    scrollController = ScrollController();
    scrollController.addListener(() async {
      widget.scrollCallback(scrollController.offset);
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

    Future.delayed(
      Duration.zero,
      () async {
        _iBookingViewModel.setIsMyList(false);
        await _iBookingViewModel.init(
          EnumHelper.getValue(
            EnumMap.bookingStatus,
            BookingStatus.available,
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IBookingViewModel>(
      builder: (context, vm, child) {
        widget.animationController.forward();
        return Padding(
          padding: EdgeInsets.only(
            top: 60.h,
          ),
          child: ListBooking(
            controller: scrollController,
            bookings: vm.bookings,
            mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: const Interval(
                  (1 / 10) * 3,
                  1.0,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
            ),
            mainScreenAnimationController: widget.animationController,
          ),
        );
      },
    );
  }
}
