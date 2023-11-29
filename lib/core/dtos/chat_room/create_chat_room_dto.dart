import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
part 'create_chat_room_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateChatRoomDto {
  String? userId;

  CreateChatRoomDto({
    this.userId,
  });
  factory CreateChatRoomDto.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRoomDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateChatRoomDtoToJson(this);
}
