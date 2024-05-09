// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';

import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';

import '../../../../core/utils/color_utils.dart';

class RecommendLocationTextField extends StatefulWidget {
  final Function(String value)? onLocationChanged;
  final Function(String value)? onDestinationChanged;
  final Function()? onTapLocation;
  final Function()? onTapDestination;
  final FocusNode? locationFocusNode;
  final FocusNode? destinationFocusNode;
  final TextEditingController locationTextEditingController;
  final TextEditingController destinationTextEditingController;
  final bool isFocus;
  const RecommendLocationTextField({
    Key? key,
    this.onLocationChanged,
    this.onDestinationChanged,
    this.onTapLocation,
    this.onTapDestination,
    this.locationFocusNode,
    this.destinationFocusNode,
    required this.locationTextEditingController,
    required this.destinationTextEditingController,
    required this.isFocus,
  }) : super(key: key);

  @override
  State<RecommendLocationTextField> createState() =>
      _RecommendLocationTextFieldState();
}

class _RecommendLocationTextFieldState extends State<RecommendLocationTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          String temp = widget.locationTextEditingController.text;
          widget.locationTextEditingController.text =
              widget.destinationTextEditingController.text;
          widget.destinationTextEditingController.text = temp;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IBookingViewModel>(
      builder: (context, vm, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: vm.onChangePlace && widget.isFocus
                      ? SizedBox(
                          width: 360.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Đang xác minh địa chỉ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                lottie.Lottie.asset(
                                  "assets/lottie/loading_text_field.json",
                                  repeat: true,
                                  height: 60.h,
                                  width: 60.h,
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 400.w,
                          child: CupertinoTextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                            ),
                            onSubmitted: (value) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {});
                            },
                            focusNode: widget.locationFocusNode,
                            onChanged: widget.onLocationChanged,
                            controller: widget.locationTextEditingController,
                            prefix: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              child: Icon(
                                Icons.person_pin,
                                color: widget.locationFocusNode!.hasFocus
                                    ? ColorUtils.primaryColor
                                    : Colors.black,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.withOpacity(
                                    0.1,
                                  ),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 15.h,
                              horizontal: 0.w,
                            ),
                            placeholder: 'Điểm đi',
                            placeholderStyle:
                                widget.locationTextEditingController.text == ''
                                    ? TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey,
                                      )
                                    : TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.sp,
                                      ),
                          ),
                        ),
                ),
                if (vm.onChangePlace && !widget.isFocus)
                  SizedBox(
                    width: 310.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Đang xác minh địa chỉ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                            ),
                          ),
                          lottie.Lottie.asset(
                            "assets/lottie/loading_text_field.json",
                            repeat: true,
                            height: 60.h,
                            width: 60.h,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: 400.w,
                    child: CupertinoTextField(
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.sp,
                      ),
                      onSubmitted: (value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {});
                      },
                      focusNode: widget.destinationFocusNode,
                      onChanged: widget.onDestinationChanged,
                      controller: widget.destinationTextEditingController,
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Icon(
                          Icons.location_pin,
                          color: widget.destinationFocusNode!.hasFocus
                              ? ColorUtils.primaryColor
                              : Colors.orange,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                          0.1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 0.w,
                      ),
                      placeholder: 'Điểm đến',
                      placeholderStyle:
                          widget.destinationTextEditingController.text == ''
                              ? TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey,
                                )
                              : TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
