import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/ui/screens/booking/widget/list_booking_item.dart';

class ListBooking extends StatefulWidget {
  final List<BookingDto> bookings;
  final ScrollController? controller;
  const ListBooking({
    Key? key,
    required this.bookings,
    this.controller,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  State<ListBooking> createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.mainScreenAnimationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.mainScreenAnimation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
              child: ListView.builder(
                controller: widget.controller,
                padding: EdgeInsets.only(top: 0.h),
                physics: widget.controller != null
                    ? null
                    : const NeverScrollableScrollPhysics(),
                shrinkWrap: widget.controller != null ? false : true,
                itemBuilder: (ctx, index) {
                  final int count =
                      widget.bookings.length > 10 ? 10 : widget.bookings.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return ListBookingItem(
                    isChatbot: false,
                    booking: widget.bookings[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
                itemCount: widget.bookings.length,
              ),
            ),
          );
        });
  }
}
