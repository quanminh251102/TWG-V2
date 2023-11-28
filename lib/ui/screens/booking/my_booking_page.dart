import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';

import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/ui/screens/booking/widget/list_booking.dart';
import 'package:twg/ui/screens/booking/widget/list_booking_item.dart';

import 'widget/my_booking_item.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({super.key});

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  bool isLoading_getMyBook = false;
  List<BookingDto> bookings = [];
  List<BookingDto> bookings_selected = [];
  TextEditingController _startPoint = TextEditingController();
  TextEditingController _endPoint = TextEditingController();
  late FocusNode startPointFocus;
  late FocusNode endPointFocus;
  late IBookingViewModel _iBookingViewModel;

  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iBookingViewModel.setIsMyList(true);
    // scrollController = ScrollController();
    Future.delayed(Duration.zero, () async {
      await _iBookingViewModel.initMyBookings();
      bookings = _iBookingViewModel.bookings;
      bookings_selected = bookings;
      print('booking length :${_iBookingViewModel.bookings.length}');
      print('select booking length :${bookings_selected.length}');
      setState(() {});
    });
    // TODO: implement initState
    super.initState();

    startPointFocus = FocusNode();
    endPointFocus = FocusNode();
  }

  void do_filter() {
    setState(() {
      print("do filter");
      bookings_selected = bookings.where((booking) {
        String booking_startPoint =
            booking.startPointMainText.toString().toLowerCase() +
                booking.startPointAddress.toString().toLowerCase();
        String booking_endPoint =
            booking.endPointMainText.toString().toLowerCase() +
                booking.endPointAddress.toString().toLowerCase();
        String search_startPoint = _startPoint.text.trim().toLowerCase();
        String search_endPoint = _endPoint.text.trim().toLowerCase();

        if (booking_startPoint.contains(search_startPoint) &&
            booking_endPoint.contains(search_endPoint)) {
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
        Text('Điểm đi : '),
        TextFormField(
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
            hintText: 'Điểm đi',
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
        Text('Điểm đến : '),
        TextFormField(
          style: const TextStyle(fontWeight: FontWeight.w600),
          focusNode: endPointFocus,
          controller: _endPoint,
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
            filled: true, //<-- SEE HERE
            fillColor: endPointFocus.hasFocus
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
            hintText: 'Điểm đến',
            prefixIcon: Icon(
              Icons.location_on,
              color: endPointFocus.hasFocus
                  ? ColorUtils.primaryColor
                  : Colors.black,
            ),
          ),
          onChanged: (text) {
            do_filter();
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Các chuyến đi đã đăng'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: isLoading_getMyBook
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...search_bar(),
                    if (bookings_selected.length == 0)
                      Center(
                          child: Column(
                        children: [
                          Image.asset('assets/images/error.png'),
                          const Text(
                            'Danh sách trống!',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                    if (bookings_selected.length > 0)
                      for (var booking in bookings_selected) ...[
                        ListBookingItem(
                          booking: booking,
                        ),
                        const SizedBox(height: 12),
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
            ),
    );
  }
}
