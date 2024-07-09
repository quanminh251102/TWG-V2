import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ichatbot_viewmodel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:twg/ui/screens/booking/widget/list_booking_item.dart';
import 'package:twg/ui/screens/booking/widget/list_recommend_item.dart';
import 'package:twg/ui/screens/chatbot/widget/pick_location_dialog.dart';

import '../../../../core/utils/text_style_utils.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late IChatbotViewModel _iChatbotViewModel;
  bool isShowChips = true;
  int tag = -1;
  List<String> options = [
    'Gợi ý chuyến đi cho tôi',
    'Làm thế nào để đăng bài ?',
    'Làm thế nào để tôi có thể đăng ký đi chung ?',
  ];
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

  Future<void> _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.TextMessage) {
      if (message.text == "Nhấp vào đây để chọn điểm xuất phát📍") {
        Get.bottomSheet(const ChatPickLocationDialog(
          isStartPlace: true,
        ));
      } else if (message.text == "Nhấp vào đây để chọn điểm đến📍") {
        Get.bottomSheet(const ChatPickLocationDialog(
          isStartPlace: false,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IChatbotViewModel>(builder: (context, vm, child) {
      return Stack(
        children: [
          Chat(
            customMessageBuilder: (message, {required messageWidth}) {
              BookingDto recommendBooking = BookingDto.fromJson(
                message.metadata!,
              );
              return ListBookingItem(
                booking: recommendBooking,
                isChatbot: true,
              );
            },
            onMessageTap: _handleMessageTap,
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
              sendButtonAccessibilityLabel: "Gửi",
            ),
            theme: DefaultChatTheme(
                inputBackgroundColor: ColorUtils.primaryColor,
                backgroundColor: Colors.transparent,
                inputTextCursorColor: ColorUtils.primaryColor,
                receivedMessageBodyTextStyle: TextStyleUtils.contentRegular(),
                sentMessageBodyTextStyle: TextStyleUtils.contentRegular(
                  color: Colors.white,
                ),
                primaryColor: ColorUtils.primaryColor,
                dateDividerTextStyle: TextStyleUtils.contentSemibold(),
                inputTextStyle: TextStyleUtils.contentSemibold(
                  color: Colors.white,
                ),
                sendButtonIcon: Image.asset(
                  "assets/images/send.png",
                  height: 25,
                )),
          ),
          Visibility(
            visible: isShowChips,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: kBottomNavigationBarHeight + 30.h,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ChipsChoice<int>.single(
                  value: tag,
                  onChanged: (val) => setState(() => tag = val),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: options,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  choiceBuilder: (item, i) {
                    return CustomChip(
                      label: item.label,
                      height: 40.h,
                      color: ColorUtils.primaryColor.withOpacity(
                        0.1,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      selected: item.selected,
                      onSelect: (selected) async {
                        item.select!;
                        setState(() {
                          isShowChips = false;
                        });
                        await _iChatbotViewModel.sendMessage(item.label);
                      },
                    );
                  },
                  direction: Axis.vertical,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      elevation: 3,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.r,
            ),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
          onTap: () => onSelect(!selected),
          child: Padding(
            padding: EdgeInsets.all(
              10.r,
            ),
            child: Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                color: ColorUtils.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
