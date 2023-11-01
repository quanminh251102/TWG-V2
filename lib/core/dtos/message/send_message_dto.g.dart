// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageDto _$SendMessageDtoFromJson(Map<String, dynamic> json) =>
    SendMessageDto(
      chatRoomId: json['chatRoomId'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$SendMessageDtoToJson(SendMessageDto instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'message': instance.message,
      'type': instance.type,
    };
