// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    NotificationDto(
      receiver: json['receiver'] == null
          ? null
          : AccountDto.fromJson(json['receiver'] as Map<String, dynamic>),
      author: json['author'] == null
          ? null
          : AccountDto.fromJson(json['author'] as Map<String, dynamic>),
      text: json['text'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$NotificationDtoToJson(NotificationDto instance) =>
    <String, dynamic>{
      'receiver': instance.receiver?.toJson(),
      'author': instance.author?.toJson(),
      'text': instance.text,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };
