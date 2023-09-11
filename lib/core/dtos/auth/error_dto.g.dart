// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDetailsDto _$ErrorDetailsDtoFromJson(Map<String, dynamic> json) =>
    ErrorDetailsDto(
      code: json['code'] as int,
      message: json['message'] as String,
      details: json['details'] as String?,
    );

Map<String, dynamic> _$ErrorDetailsDtoToJson(ErrorDetailsDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'details': instance.details,
    };
