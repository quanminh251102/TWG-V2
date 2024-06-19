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
  late ILocationViewModel _iLocationViewModel;
  late ScrollController scrollController;
  late ScrollController horizontalController;
  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iLocationViewModel = context.read<ILocationViewModel>();
    scrollController = ScrollController();
    horizontalController = ScrollController();
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
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.w,
                right: 8.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: Lottie.asset(
                          'assets/lottie/new-booking.json',
                          fit: BoxFit.fill,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                      Text(
                        'Dành cho bạn',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.h,
                    ),
                    child: InkWell(
                      onTap: () => Get.toNamed(MyRouter.forYouScreen),
                      child: Row(
                        children: [
                          Text(
                            'Xem thêm',
                            style: TextStyle(
                              color: ColorUtils.primaryColor,
                              fontSize: 16.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: ColorUtils.primaryColor,
                            size: 15.sp,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Consumer<IBookingViewModel>(
              builder: (context, vm, child) {
                return SizedBox(
                    height: 260.h,
                    width: double.infinity,
                    child: Skeletonizer(
                        enabled: vm.recommendBooking.isEmpty,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.95,
                            aspectRatio: 1.5,
                            reverse: false,
                            enableInfiniteScroll: false,
                            initialPage: 0,
                          ),
                          items: vm.recommendBooking.isEmpty
                              ? BookingDto.bookingsFake
                                  .map((e) => ListRecommendItem(
                                        booking: e,
                                      ))
                                  .toList()
                              : vm.recommendBooking
                                  .map((e) => ListRecommendItem(
                                        booking: e,
                                      ))
                                  .toList(),
                        )));
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.w,
              ),
              child: Row(
                children: [
                  Lottie.asset(
                    'assets/lottie/recommend-flame.json',
                    fit: BoxFit.fill,
                    height: 40.h,
                    width: 30.w,
                  ),
                  Text(
                    'Hoạt động',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Consumer<IBookingViewModel>(
              builder: (context, vm, child) {
                widget.animationController.forward();
                return Skeletonizer(
                    enabled: vm.bookings.isEmpty,
                    child: ListBooking(
                      bookings: vm.bookings.isEmpty
                          ? BookingDto.bookingsFake
                          : vm.bookings,
                      mainScreenAnimation:
                          Tween<double>(begin: 0.0, end: 1.0).animate(
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
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
