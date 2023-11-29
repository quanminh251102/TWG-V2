import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/services/interfaces/ichat_room_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class ChatRoomService implements IChatRoomService {
  int _total = 0;
  @override
  int get total => _total;
  @override
  Future<List<ChatRoomDto>?> getChatRooms({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? userId1,
    String? userId2,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getChatRooms(
          token: token,
          page: page,
          pageSize: pageSize,
          userId1: userId1,
          userId2: userId2);

      if (result.success) {
        _total = result.total ?? 0;
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<ChatRoomDto?> createChatRoom(CreateChatRoomDto value) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().createChatRoom(
        token.toString(),
        value,
      );

      if (result.success) {
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
