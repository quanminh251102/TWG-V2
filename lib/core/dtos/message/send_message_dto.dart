import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'send_message_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SendMessageDto {
  String? chatRoomId;
  String? message;
  String? type;

  SendMessageDto({
    this.chatRoomId,
    this.message,
    this.type,
  });
  factory SendMessageDto.fromJson(Map<String, dynamic> json) =>
      _$SendMessageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SendMessageDtoToJson(this);
}
