// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../booking_screen.dart';

class _ForYouBookingTab extends StatefulWidget {
  final AnimationController animationController;
  final Function(double scrollOffset) scrollCallback;
  final bool isRecommend;
  const _ForYouBookingTab({
    Key? key,
    required this.animationController,
    required this.scrollCallback,
    required this.isRecommend,
  }) : super(key: key);
  @override
  State<_ForYouBookingTab> createState() => ___ForYouBookingTabState();
}

class ___ForYouBookingTabState extends State<_ForYouBookingTab> {
  late final ScrollController scrollController;
  late IBookingViewModel _iBookingViewModel;
  late ILocationViewModel _iLocationViewModel;
  TextEditingController locationTextEditingController = TextEditingController();
  final FocusNode locationFocusNode = FocusNode();
  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iLocationViewModel = context.read<ILocationViewModel>();
    scrollController = ScrollController();

    Future.delayed(Duration.zero, () async {
      await _iLocationViewModel.getSavedLocation();
      if (!widget.isRecommend) {
        await _iBookingViewModel.getRecommendBooking(
          type: 'from_user',
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 60.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: 125.h,
              ),
              child: const RecommendTextField(),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(child: Consumer<IBookingViewModel>(
            builder: (context, vm, child) {
              widget.animationController.forward();
              return MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListBooking(
                  controller: scrollController,
                  bookings: vm.bookings,
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
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
