import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/ichatbot_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/chatbot/widget/message_screen.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late IChatbotViewModel _iChatbotViewModel;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _iChatbotViewModel = context.read<IChatbotViewModel>();
    Future.delayed(
      Duration.zero,
      () async {
        await _iChatbotViewModel.initConversation();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leadingWidth: 200.w,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.offNamed(
                    MyRouter.home,
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                'assets/lottie/chatbot_ava.gif',
                fit: BoxFit.fill,
                height: 60.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chatbot',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
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
        ),
      ),
      body: const MessagesScreen(),
    );
  }
}
