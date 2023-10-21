import 'package:flutter/material.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/ui/screens/chat_room/widget/list_message_item.dart';

class ListMessage extends StatelessWidget {
  final List<MessageDto> Messages;
  const ListMessage({
    Key? key,
    required this.Messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListMessageItem(
          Message: Messages[index],
        );
      },
      itemCount: Messages.length,
    );
  }
}
