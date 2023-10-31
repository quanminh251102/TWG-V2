import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/ui/screens/chat_room/widget/list_message_item.dart';

class ListMessage extends StatefulWidget {
  final List<MessageDto> Messages;
  const ListMessage({
    Key? key,
    required this.Messages,
  }) : super(key: key);

  @override
  State<ListMessage> createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessage> {
  ScrollController scrollController = ScrollController();

  late IMessageViewModel _iMessageViewModel;

  @override
  void initState() {
    _iMessageViewModel = context.read<IMessageViewModel>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _iMessageViewModel.jumbToLastMessage();
    });

    return ListView.builder(
      controller: _iMessageViewModel.scrollController,
      itemBuilder: (ctx, index) {
        return ListMessageItem(
          Message: widget.Messages[index],
        );
      },
      itemCount: widget.Messages.length,
    );
  }
}
