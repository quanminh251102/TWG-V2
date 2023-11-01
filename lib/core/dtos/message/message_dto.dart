import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageDto {
  String? chatRoomId;
  AccountDto? userId;
  String? message;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? id;

  MessageDto(
      {this.chatRoomId,
      this.userId,
      this.message,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.id});
  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
