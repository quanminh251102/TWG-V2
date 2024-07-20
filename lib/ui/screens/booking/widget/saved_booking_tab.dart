part of '../booking_screen.dart';

class _SaveBookingTab extends StatefulWidget {
  final AnimationController animationController;
  final Function(double scrollOffset) scrollCallback;
  const _SaveBookingTab({
    Key? key,
    required this.animationController,
    required this.scrollCallback,
  }) : super(key: key);

  @override
  State<_SaveBookingTab> createState() => ___SaveBookingTabState();
}

class ___SaveBookingTabState extends State<_SaveBookingTab> {
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
          await _iBookingViewModel.getMoreSaveBookings();
        }
      }
    });

    Future.delayed(
      Duration.zero,
      () async {
        _iBookingViewModel.setIsMyList(false);
        await _iBookingViewModel.onSearchSaveBooking();
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
            top: 150.h,
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
