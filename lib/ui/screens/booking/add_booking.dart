// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/money_utils.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_button.dart';

enum BookingType { findDriver, findPassenger }

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

String formatString(String input) {
  if (input.length > 30) {
    return input.substring(0, 27) + "...";
  } else {
    return input;
  }
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  TextEditingController textEditingController = TextEditingController();

  late TextEditingController time;
  late TextEditingController startPlace;
  late TextEditingController endPlace;
  late TextEditingController price;
  late GlobalKey<FormState> _formKey;
  DateTime _selectedDateTime = DateTime.now();
  BookingType _bookingType = BookingType.findDriver;

  bool isLoading = false;
  late IBookingViewModel _iBookingViewModel;
  @override
  void initState() {
    super.initState();
    _iBookingViewModel = context.read<IBookingViewModel>();

    _formKey = GlobalKey<FormState>();
    startPlace = TextEditingController(
      text:
          '${_iBookingViewModel.currentBooking!.startPointMainText}, ${_iBookingViewModel.currentBooking!.startPointAddress}',
    );
    endPlace = TextEditingController(
      text:
          '${_iBookingViewModel.currentBooking!.endPointMainText}, ${_iBookingViewModel.currentBooking!.endPointAddress}',
    );
    time = TextEditingController();
    price = TextEditingController();
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.inputOnly,
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: ColorUtils.primaryColor,
              dialogTheme: const DialogTheme(
                  backgroundColor: ColorUtils.primaryColor,
                  titleTextStyle: TextStyle(color: Colors.white),
                  contentTextStyle: TextStyle(color: Colors.black))),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (timePicked != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            timePicked.hour,
            timePicked.minute,
          );
          final DateFormat formatter = DateFormat('HH:mm | dd/MM/yyyy');
          time.text = formatter.format(_selectedDateTime).toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'ĐĂNG BÀI',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Consumer<IBookingViewModel>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Địa điểm',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                readOnly: true,
                                onTap: () {
                                  Get.toNamed(MyRouter.pickPlaceMap);
                                },
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                controller: startPlace,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Vui lòng nhập điểm đi";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorUtils.grey.withOpacity(0.1),
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: 'Điểm đi',
                                  prefixIcon: Icon(
                                    Icons.person_pin,
                                    color: startPlace.text != ''
                                        ? ColorUtils.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            TextFormField(
                              readOnly: true,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              controller: endPlace,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vui lòng nhập điểm đến";
                                }
                                return null;
                              },
                              onTap: () {
                                Get.toNamed(MyRouter.pickPlaceMap);
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                focusColor: Colors.black,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorUtils.grey.withOpacity(0.1),
                                    width: 2.0,
                                  ),
                                ),
                                hintText: 'Điểm đến',
                                prefixIcon: Icon(
                                  Icons.place_outlined,
                                  color: endPlace.text != ''
                                      ? ColorUtils.primaryColor
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const Text(
                              'Thời gian',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                controller: time,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Vui lòng chọn thời gian";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    filled: true, //<-- SEE HERE
                                    fillColor: Colors.white,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorUtils.primaryColor,
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.1),
                                        width: 2.0,
                                      ),
                                    ),
                                    hintText: 'Thời gian',
                                    prefixIcon: IconButton(
                                      onPressed: () => selectDateTime(context),
                                      icon: const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Text(
                              'Giá tiền',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: TextFormField(
                                inputFormatters: [
                                  VietnameseMoneyFormatter(),
                                ],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                controller: price,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Vui lòng nhập giá tiền";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    filled: true, //<-- SEE HERE
                                    fillColor: Colors.white,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorUtils.primaryColor,
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.1),
                                        width: 2.0,
                                      ),
                                    ),
                                    hintText: 'Giá tiền',
                                    prefixIcon: IconButton(
                                      onPressed: () => selectDateTime(context),
                                      icon: const Icon(
                                        Icons.price_change_outlined,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Text(
                              'Nội dung',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                              ),
                              child: SizedBox(
                                child: TextField(
                                  controller: textEditingController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.h,
                                      horizontal: 20.w,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffF2F2F3)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorUtils.borderColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    hintText:
                                        "Mình cần tìm người đi cùng chiều nay...",
                                    hintStyle: const TextStyle(
                                        color: Color(0xff616161),
                                        fontFamily: "AvertaStdCY-Regular"),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  maxLines: 100,
                                  minLines: 5,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 20),
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : InkWell(
                                      onTap: () async {
                                        await _iBookingViewModel.createBooking(
                                          time: time.text,
                                          price: price.text,
                                          content: textEditingController.text,
                                        );
                                      },
                                      child: Center(
                                        child: CustomButton(
                                          height: 50.h,
                                          width: 300.w,
                                          text: 'Thêm bài viết',
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            if (isLoading)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20),
                                child: Align(
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    child: Container(
                                        height: screenSize.height * 0.06,
                                        width: screenSize.width * 0.8,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                          child: Text(
                                            'Hủy',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
