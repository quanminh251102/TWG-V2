import 'package:flutter/material.dart';
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
  late final ScrollController scrollController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _iChatRoomViewModel = context.read<IChatRoomViewModel>();

    scrollController = ScrollController();
    Future.delayed(Duration.zero, () async {
      await _iChatRoomViewModel.init('');
    });
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          await _iChatRoomViewModel.getMoreChatRooms('');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavBarV2(
          currentIndex: 3,
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Trò chuyện',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          actions: const [
            NotificationWidget(),
          ],
        ),
        extendBody: true,
        body: Column(
          children: [
            Expanded(
              child: Consumer<IChatRoomViewModel>(
                builder: (context, vm, child) {
                  return ListChatRoom(
                    ChatRooms: vm.ChatRooms,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
