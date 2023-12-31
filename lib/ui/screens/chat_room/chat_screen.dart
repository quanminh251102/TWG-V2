import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/call/call_info_dto.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/ui/screens/chat_room/widget/list_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  // late TabController _tabController;
  late IMessageViewModel _iMessageViewModel;
  late final ScrollController scrollController;
  late ICallViewModel _iCallViewModel;

  late TextEditingController _controller = TextEditingController();
  ScrollController controller = new ScrollController();
  // ItemScrollController itemScrollController = new ItemScrollController();
  // final ItemPositionsListener itemPositionsListener =
  //     ItemPositionsListener.create();
  late bool isFirstTimeNavigateToPage = true;
  late bool isTop = true;
  late bool isNotTop = false;
  late bool isLoading = false;
  List<int> indexOnViews = [];
  bool _isLoading = false;
  int numLoad = 1;
  // List<Message> list = [];
  //late IO.Socket socket;

  bool stateIsKeyBoardShow = false;

  bool _isLoadingImage = false;

  @override
  void initState() {
    _iCallViewModel = context.read<ICallViewModel>();
    // _tabController = TabController(
    //   length: 2,
    //   vsync: this,
    // );
    _iMessageViewModel = context.read<IMessageViewModel>();

    scrollController = ScrollController();
    Future.delayed(Duration.zero, () async {
      await _iMessageViewModel.init('');
    });
    // scrollController.addListener(() async {
    //   if (scrollController.position.atEdge) {
    //     bool isTop = scrollController.position.pixels == 0;
    //     if (!isTop) {
    //       await _iMessageViewModel.getMoreMessages('');
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _iMessageViewModel.removeMessageEvent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // scrollController.jumpTo(double.infinity);
    const appBarHeight = 80.0;
    const botttomNavigatebarHeight = 80.0;
    final bodyHeight = MediaQuery.of(context).size.height -
        appBarHeight -
        botttomNavigatebarHeight;

    final isKeyBoardShow = MediaQuery.of(context).viewInsets.bottom > 0;
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    final current_user_id = '';

    final partner = _iMessageViewModel.getPartner();
    final _appBar = AppBar(
      toolbarHeight: appBarHeight,
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        onPressed: () {
          // BlocProvider.of<MessageCubit>(context).leave_chat_room();
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              partner!.avatarUrl.toString(),
              // "https://res.cloudinary.com/dxoblxypq/image/upload/v1679984586/9843c460ff72ee89d791bffe667e451c_rzalqh.jpg",
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // HandleString.validateForLongStringWithLim(
                //   (SocketProvider.current_user_id == widget.chatRoom.UserId1
                //       ? widget.chatRoom.UserName2
                //       : widget.chatRoom.UserName1),
                //   10,
                // ),
                partner!.firstName.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const Text(
                'Online',
                style: TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // IconButton(
        //   onPressed: () {
        //     //make_call('just_audio');
        //   },
        //   icon: const Icon(
        //     Icons.call,
        //   ),
        // ),
        IconButton(
          onPressed: () {
            _iCallViewModel
                .makeCall(_iMessageViewModel.getCallInfo() as CallInfoDto);
          },
          icon: const Icon(
            Icons.video_call_sharp,
          ),
        ),
      ],
    );

    final _bottomNavigationBar = SizedBox(
      height: botttomNavigatebarHeight,
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8EAF3),
            ),
          ),
        ),
        child: Row(
          children: [
            // Container(
            //   width: 100,
            //   decoration: BoxDecoration(
            //       color: const Color(0xFFE8FDF2),
            //       borderRadius: BorderRadius.circular(8)),
            //   padding: const EdgeInsets.all(12),
            //   child: const Text(
            //     'Bắt đầu tư vấn',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Color(0xFF0E9D57),
            //       fontSize: 15,
            //     ),
            //   ),
            // ),
            // const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Viết tin nhắn',
                  suffixIcon: InkWell(
                      onTap: () {
                        print("upload image");
                        // openMediaDialog();
                      },
                      child: const Icon(
                        Icons.image,
                        // color: AppColors.primaryColor,
                      )),
                ),
              ),
            ),
            IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.send,
                // color: AppColors.primaryColor,
              ),
              onPressed: () {
                // BlocProvider.of<MessageCubit>(context)
                //     .send_message_to_chat_room(
                //   _controller.text.trim(),
                //   "isText",
                // );
                _iMessageViewModel.sendMessage(_controller.text.trim());
                _controller.text = "";
                // if (list.length > 0) {
                //   itemScrollController.jumpTo(index: list.length);
                // }
              },
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Scaffold(
          appBar: _appBar,
          bottomNavigationBar: _bottomNavigationBar,
          // floatingActionButton: const CustomFloatingButton(),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // bottomNavigationBar: const CustomBottomNavigationBar(
          //   value: CustomNavigationBar.chat,
          // ),
          body: Column(
            children: [
              Expanded(
                child: Consumer<IMessageViewModel>(
                  builder: (context, vm, child) {
                    return ListMessage(
                      Messages: vm.Messages,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
