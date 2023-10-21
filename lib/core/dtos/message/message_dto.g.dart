// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      chatRoomId: json['chatRoomId'] as String?,
      userId: json['userId'] == null
          ? null
          : AccountDto.fromJson(json['userId'] as Map<String, dynamic>),
      message: json['message'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'userId': instance.userId?.toJson(),
      'message': instance.message,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };
