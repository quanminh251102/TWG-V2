import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/common_widgets/custom_bottom_navigation_bar.dart';
import 'package:twg/ui/common_widgets/custom_booking_floating_button.dart';
import 'package:twg/ui/common_widgets/confirm_login_dialog.dart';
import 'package:twg/ui/screens/booking/widget/create_post_bottom_sheet.dart';
import 'package:twg/ui/screens/booking/widget/place_text_field.dart';
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
  // late IChatRoomViewModel _iChatRoomViewModel;
  // late ICallViewModel _iCallViewModel;
  // final ISocketService _iSocketService = locator<ISocketService>();
  // late IApplyViewModel _iApplyViewModel;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    // _iChatRoomViewModel = context.read<IChatRoomViewModel>();
    // _iChatRoomViewModel.initSocketEventForChatRoom();

    // _iApplyViewModel = context.read<IApplyViewModel>();
    // _iApplyViewModel.initSocketEventForApply();

    // _iCallViewModel = context.read<ICallViewModel>();
    // _iCallViewModel.initSocketEventForCall();
    // _iCallViewModel.setSocket(_iSocketService.socket as IO.Socket);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomHomeAppBar(),

      bottomNavigationBar: const CustomBottomNavigationBar(
        value: CustomNavigationBar.booking,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Bài đăng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.note_add_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              if (locator<GlobalData>().currentUser != null) {
                Get.bottomSheet(
                  const CreatePostSheet(),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                );
              } else {
                Get.dialog(
                  const ConfirmLoginDialog(),
                );
              }
            },
          )
        ],
      ),
      body: _AvailableBookingTab(),
    );
  }
}
