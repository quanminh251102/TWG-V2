import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';

abstract class IChatRoomService {
  Future<List<ChatRoomDto>?> getChatRooms({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? userId1,
    String? userId2,
  });
  int get total;
}
