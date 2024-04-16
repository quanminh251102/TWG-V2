// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:twg/ui/common_widgets/action_button.dart';
import '../../../../core/utils/color_utils.dart';

class PlaceTextField extends StatefulWidget {
  final Function(String value)? onLocationChanged;
  final Function(String value)? onDestinationChanged;
  final FocusNode? locationFocusNode;
  final FocusNode? destinationFocusNode;
  final TextEditingController locationTextEditingController;
  final TextEditingController destinationTextEditingController;
  bool isFocus;
  PlaceTextField({
    Key? key,
    this.onLocationChanged,
    this.onDestinationChanged,
    this.locationFocusNode,
    this.destinationFocusNode,
    required this.locationTextEditingController,
    required this.destinationTextEditingController,
    required this.isFocus,
  }) : super(key: key);

  @override
  State<PlaceTextField> createState() => _PlaceTextFieldState();
}

class _PlaceTextFieldState extends State<PlaceTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  PickerDateRange? _selectedDateRange;
  PickerDateRange? _onChangeDateRange;
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    _onChangeDateRange = args.value;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Chọn ngày',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: 300.h,
            width: 350.w,
            child: SfDateRangePicker(
              onSubmit: (p0) {
                setState(() {
                  if (_onChangeDateRange != null) {
                    _selectedDateRange = _onChangeDateRange!;
                    _range =
                        'T${DateFormat('dd MM').format(_onChangeDateRange!.startDate!)} -'
                        ' T${DateFormat('dd MM').format(_onChangeDateRange!.endDate ?? _onChangeDateRange!.startDate!)}';
                    Get.back();
                  }
                });
              },
              onCancel: () => Get.back(),
              showActionButtons: true,
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: _selectedDateRange ??
                  PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3)),
                  ),
            ),
          ),
        );
      },
    );
  }

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
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
                        vm.onChangePlace && widget.isFocus
                            ? SizedBox(
                                width: 310.w,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Đang xác minh địa chỉ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
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
                                width: 310.w,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    onSubmitted: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(() {});
                                    },
                                    focusNode: widget.locationFocusNode,
                                    onChanged: widget.onLocationChanged,
                                    controller:
                                        widget.locationTextEditingController,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorUtils.primaryColor,
                                              width: 2.h)),
                                      border: InputBorder.none,
                                      labelText: 'Điểm đi',
                                      labelStyle: widget
                                                  .locationTextEditingController
                                                  .text ==
                                              ''
                                          ? TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                            )
                                          : TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                            ),
                                      suffixIcon: widget
                                              .locationTextEditingController
                                              .text
                                              .isNotEmpty
                                          ? IconButton(
                                              icon: Icon(Icons.clear,
                                                  color: widget
                                                          .locationFocusNode!
                                                          .hasFocus
                                                      ? ColorUtils.primaryColor
                                                      : Colors.black),
                                              onPressed: () {
                                                setState(() {
                                                  widget
                                                      .locationTextEditingController
                                                      .clear();
                                                });
                                              },
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Icon(
                            Icons.location_pin,
                            color: widget.destinationFocusNode!.hasFocus
                                ? ColorUtils.primaryColor
                                : Colors.black,
                          ),
                        ),
                        vm.onChangePlace && !widget.isFocus
                            ? SizedBox(
                                width: 310.w,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Đang xác minh địa chỉ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
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
                                width: 310.w,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    focusNode: widget.destinationFocusNode,
                                    onChanged: widget.onDestinationChanged,
                                    onSubmitted: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(() {});
                                    },
                                    controller:
                                        widget.destinationTextEditingController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorUtils.primaryColor,
                                              width: 2.h)),
                                      labelText: 'Điểm đến',
                                      labelStyle:
                                          widget.destinationTextEditingController
                                                      .text ==
                                                  ''
                                              ? TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.grey,
                                                )
                                              : TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.sp,
                                                ),
                                      suffixIcon: widget
                                              .destinationTextEditingController
                                              .text
                                              .isNotEmpty
                                          ? IconButton(
                                              icon: Icon(Icons.clear,
                                                  color: widget
                                                          .destinationFocusNode!
                                                          .hasFocus
                                                      ? ColorUtils.primaryColor
                                                      : Colors.black),
                                              onPressed: () {
                                                setState(() {
                                                  widget
                                                      .destinationTextEditingController
                                                      .clear();
                                                });
                                              },
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () {
                    _controller.reset();
                    _controller.forward();
                  },
                  child: RotationTransition(
                    turns: _animation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                          0.3,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: const Icon(
                          Icons.swap_vert,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
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
