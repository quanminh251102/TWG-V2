// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:lottie/lottie.dart' as lottie;
import '../../../../core/utils/color_utils.dart';

class LocationTextField extends StatefulWidget {
  final Function(String value)? onLocationChanged;
  final FocusNode? locationFocusNode;
  final TextEditingController locationTextEditingController;
  bool isFocus;
  LocationTextField({
    Key? key,
    this.onLocationChanged,
    this.locationFocusNode,
    required this.locationTextEditingController,
    required this.isFocus,
  }) : super(key: key);

  @override
  State<LocationTextField> createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IBookingViewModel>(
      builder: (context, vm, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vm.onChangePlace && widget.isFocus
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
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
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                      ),
                      child: CupertinoTextField(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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
                            color: Colors.grey.withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(
                              10.r,
                            )),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 0.w,
                        ),
                        placeholder: 'Địa điểm',
                        placeholderStyle:
                            widget.locationTextEditingController.text == ''
                                ? TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey,
                                  )
                                : TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
