// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomDto _$ChatRoomDtoFromJson(Map<String, dynamic> json) => ChatRoomDto(
      userId1: json['userId1'] as String?,
      user1: json['user1'] == null
          ? null
          : AccountDto.fromJson(json['user1'] as Map<String, dynamic>),
      userId2: json['userId2'] as String?,
      user2: json['user2'] == null
          ? null
          : AccountDto.fromJson(json['user2'] as Map<String, dynamic>),
      numUnwatched1: json['numUnwatched1'] as int?,
      numUnwatched2: json['numUnwatched2'] as int?,
      id: json['id'] as String?,
    )..lastMessage = json['lastMessage'] == null
        ? null
        : MessageDto.fromJson(json['lastMessage'] as Map<String, dynamic>);

Map<String, dynamic> _$ChatRoomDtoToJson(ChatRoomDto instance) =>
    <String, dynamic>{
      'userId1': instance.userId1,
      'user1': instance.user1?.toJson(),
      'userId2': instance.userId2,
      'user2': instance.user2?.toJson(),
      'numUnwatched1': instance.numUnwatched1,
      'numUnwatched2': instance.numUnwatched2,
      'id': instance.id,
      'lastMessage': instance.lastMessage?.toJson(),
    };
