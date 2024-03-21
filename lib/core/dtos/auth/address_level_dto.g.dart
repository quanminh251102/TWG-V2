// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressLevelDto _$AddressLevelDtoFromJson(Map<String, dynamic> json) =>
    AddressLevelDto(
      level1: json['level1'] as String?,
      level2: json['level2'] as String?,
      level3: json['level3'] as String?,
      level4: json['level4'] as String?,
    );

Map<String, dynamic> _$AddressLevelDtoToJson(AddressLevelDto instance) =>
    <String, dynamic>{
      'level1': instance.level1,
      'level2': instance.level2,
      'level3': instance.level3,
      'level4': instance.level4,
    };
