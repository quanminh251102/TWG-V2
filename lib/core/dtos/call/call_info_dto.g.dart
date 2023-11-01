// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallInfoDto _$CallInfoDtoFromJson(Map<String, dynamic> json) => CallInfoDto(
      id: json['id'] as String?,
      callerId: json['callerId'] as String?,
      receiverId: json['receiverId'] as String?,
      callerName: json['callerName'] as String?,
      receiverName: json['receiverName'] as String?,
      isCaller: json['isCaller'] as bool?,
    );

Map<String, dynamic> _$CallInfoDtoToJson(CallInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'callerId': instance.callerId,
      'receiverId': instance.receiverId,
      'callerName': instance.callerName,
      'receiverName': instance.receiverName,
      'isCaller': instance.isCaller,
    };
