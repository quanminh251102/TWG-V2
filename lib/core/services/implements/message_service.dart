import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/dtos/pagination/pagination_dto.dart';
import 'package:twg/core/services/interfaces/imessage_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class MessageService implements IMessageService {
  int _total = 0;
  @override
  int get total => _total;
  @override
  Future<List<MessageDto>?> getMessages({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? chatRoomId,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getMessages(
        token: token,
        page: page,
        pageSize: pageSize,
        chat_room_id: chatRoomId,
      );

      if (result.success) {
        _total = result.total ?? 0;
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
