import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';

import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/booking/widget/booking_history_item.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({super.key});

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage>
    with SingleTickerProviderStateMixin {
  bool isLoading_getMyBook = false;
  List<BookingDto> bookings = [];
  List<BookingDto> bookings_selected = [];
  final TextEditingController _startPoint = TextEditingController();
  final TextEditingController _endPoint = TextEditingController();
  late FocusNode startPointFocus;
  late FocusNode endPointFocus;
  late IBookingViewModel _iBookingViewModel;
  TabController? _tabController;
  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iBookingViewModel.setIsMyList(true);
    setState(() {
      isLoading_getMyBook = true;
    });
    Future.delayed(Duration.zero, () async {
      await _iBookingViewModel.initMyBookings();
      bookings = _iBookingViewModel.bookings;
      bookings_selected = bookings;
      setState(() {
        isLoading_getMyBook = false;
      });
    });

    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    startPointFocus = FocusNode();
    endPointFocus = FocusNode();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void do_filter() {
    setState(() {
      print("do filter");
      bookings_selected = bookings.where((booking) {
        String bookingStartpoint =
            booking.startPointMainText.toString().toLowerCase() +
                booking.startPointAddress.toString().toLowerCase();
        String bookingEndpoint =
            booking.endPointMainText.toString().toLowerCase() +
                booking.endPointAddress.toString().toLowerCase();
        String searchStartpoint = _startPoint.text.trim().toLowerCase();
        String searchEndpoint = _startPoint.text.trim().toLowerCase();

        if (bookingStartpoint.contains(searchStartpoint) &&
            bookingEndpoint.contains(searchEndpoint)) {
          return true;
        }
        return false;
      }).toList();
      print(bookings_selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    search_bar() {
      return [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: TextFormField(
            style: const TextStyle(fontWeight: FontWeight.w600),
            focusNode: startPointFocus,
            controller: _startPoint,
            validator: (value) {
              return null;
            },
            decoration: InputDecoration(
              filled: true, //<-- SEE HERE
              fillColor: startPointFocus.hasFocus
                  ? ColorUtils.primaryColor.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: ColorUtils.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                  width: 2.0,
                ),
              ),
              hintText: 'Địa điểm...',
              prefixIcon: Icon(
                Icons.location_on,
                color: startPointFocus.hasFocus
                    ? ColorUtils.primaryColor
                    : Colors.black,
              ),
            ),
            onChanged: (text) {
              do_filter();
            },
          ),
        ),
      ];
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Chuyến đi của tôi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.r,
              ),
              color: ColorUtils.primaryColor,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: ColorUtils.primaryColor,
            tabs: [
              Tab(
                child: Text(
                  'Tài xế',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Hành khách',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: isLoading_getMyBook
            ? Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Lottie.asset(
                      'assets/lottie/loading_text.json',
                      height: 100.h,
                    )),
              )
            : TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        ...search_bar(),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (bookings_selected.isEmpty)
                          Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Lottie.asset(
                                  'assets/lottie/empty.json',
                                  height: 100.h,
                                )),
                          ),
                        if (bookings_selected.isNotEmpty)
                          for (var booking in bookings_selected) ...[
                            if (booking.bookingType == 'Tìm tài xế')
                              BookingHistoryItem(
                                booking: booking,
                              ),
                          ],
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        ...search_bar(),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (bookings_selected.isEmpty)
                          Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Lottie.asset(
                                  'assets/lottie/empty.json',
                                  height: 100.h,
                                )),
                          ),
                        if (bookings_selected.isNotEmpty)
                          for (var booking in bookings_selected) ...[
                            if (booking.bookingType == 'Tìm hành khách')
                              BookingHistoryItem(
                                booking: booking,
                              ),
                          ],
                        // Consumer<IBookingViewModel>(
                        //   builder: (context, vm, child) {
                        //     return ListBooking(
                        //       bookings: vm.bookings,
                        //     );
                        //   },
                        // ),

                        //  SizedBox(
                        //     height: 400,
                        //     child: ListView.builder(
                        //       itemBuilder: (ctx, index) {
                        //         return MyBookingItem(
                        //           booking: bookings[index],
                        //         );
                        //       },
                        //       itemCount: bookings.length,
                        //     ),
                        //   )
                      ],
                    ),
                  ),
                ],
              ));
  }
}
