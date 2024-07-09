import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/ui/common_widgets/custom_rive_nav.dart';
import 'package:twg/ui/common_widgets/notification_widget.dart';
import 'package:twg/ui/screens/chat_room/widget/list_chat_room.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late IChatRoomViewModel _iChatRoomViewModel;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _iChatRoomViewModel = context.read<IChatRoomViewModel>();

    Future.delayed(Duration.zero, () async {
      await _iChatRoomViewModel.init('');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavBarV2(
          currentIndex: 3,
        ),
        body: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                          ),
                          child: Text(
                            'Trò chuyện',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22.sp,
                              letterSpacing: 1.2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: const NotificationWidget())
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Consumer<IChatRoomViewModel>(
                builder: (context, vm, child) {
                  return vm.ChatRooms.isNotEmpty
                      ? ListChatRoom(
                          chatRooms: vm.ChatRooms,
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ));
  }
}
