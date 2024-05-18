// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ichatbot_viewmodel.dart';

import '../../../../core/utils/text_style_utils.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late IChatbotViewModel _iChatbotViewModel;
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
    return Consumer<IChatbotViewModel>(builder: (context, vm, child) {
      return Chat(
        messages: vm.responseMessages.reversed.toList(),
        onSendPressed: (text) async {
          await _iChatbotViewModel.sendMessage(text.text);
        },
        user: const types.User(id: 'User'),
        showUserAvatars: true,
        avatarBuilder: (user) {
          return Padding(
              padding: const EdgeInsets.only(right: 7),
              child: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "assets/images/chat.png",
                    color: Colors.white,
                  ),
                ),
              ));
        },
        l10n: const ChatL10nEn(
            emptyChatPlaceholder: "Trò chuyện cùng tôi nhé🤗",
            inputPlaceholder: "Bạn cần tư vấn về ....?",
            sendButtonAccessibilityLabel: "Gửi"),
        theme: DefaultChatTheme(
            inputBackgroundColor: ColorUtils.primaryColor,
            backgroundColor: Colors.transparent,
            inputTextCursorColor: ColorUtils.primaryColor,
            receivedMessageBodyTextStyle: TextStyleUtils.contentRegular(),
            sentMessageBodyTextStyle:
                TextStyleUtils.contentRegular(color: Colors.black),
            dateDividerTextStyle: TextStyleUtils.contentSemibold(),
            inputTextStyle: TextStyleUtils.contentSemibold(
              color: Colors.white,
            ),
            sendButtonIcon: Image.asset(
              "assets/images/send.png",
              height: 25,
            )),
      );
    });
  }
}
