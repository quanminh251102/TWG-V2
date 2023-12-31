import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/dtos/message/send_message_dto.dart';

abstract class IMessageService {
  Future<List<MessageDto>?> getMessages({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? chatRoomId,
  });
  int get total;
  Future<void> sendMessage({SendMessageDto value});
}
