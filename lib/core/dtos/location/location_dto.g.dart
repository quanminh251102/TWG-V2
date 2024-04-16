// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
      type: json['type'] as String?,
      placeName: json['placeName'] as String?,
      placeDescription: json['placeDescription'] as String?,
      placeId: json['placeId'] as String?,
      placeGeoCode: json['placeGeoCode'] as String?,
    );

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'placeName': instance.placeName,
      'placeDescription': instance.placeDescription,
      'placeId': instance.placeId,
      'placeGeoCode': instance.placeGeoCode,
    };
