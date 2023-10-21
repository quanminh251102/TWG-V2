import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_room_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatRoomDto {
  String? userId1;
  AccountDto? user1;
  String? userId2;
  AccountDto? user2;
  int? numUnwatched1;
  int? numUnwatched2;
  String? id;

  ChatRoomDto(
      {this.userId1,
      this.user1,
      this.userId2,
      this.user2,
      this.numUnwatched1,
      this.numUnwatched2,
      this.id});
  factory ChatRoomDto.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomDtoToJson(this);
}
