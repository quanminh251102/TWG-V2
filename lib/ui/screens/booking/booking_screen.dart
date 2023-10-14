import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/ui/common_widgets/custom_bottom_navigation_bar.dart';
import 'package:twg/ui/common_widgets/custom_order_floating_button.dart';

import 'widget/list_booking.dart';
part './widget/available_tab.dart';
part './widget/cancel_tab.dart';
part './widget/complete_tab.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomHomeAppBar(),
      floatingActionButton: const CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
        value: CustomNavigationBar.booking,
      ),
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: ColorUtils.primaryColor,
          tabs: const [
            Tab(
                child: Text(
              'Đang hoạt động',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            )),
            Tab(
                child: Text(
              'Hoàn thành',
              style: TextStyle(fontSize: 14),
            )),
            Tab(
                child: Text(
              'Đã hủy',
              style: TextStyle(fontSize: 14),
            )),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AvailableBookingTab(),
          _CancelBookingTab(),
          _CompleteBookingTab()
        ],
      ),
    );
  }
}
