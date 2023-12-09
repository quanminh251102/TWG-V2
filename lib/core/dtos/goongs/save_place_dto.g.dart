// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavePlaceDto _$SavePlaceDtoFromJson(Map<String, dynamic> json) => SavePlaceDto(
      type: json['type'] as String?,
      placeName: json['placeName'] as String?,
      placeDescription: json['placeDescription'] as String?,
      placeId: json['placeId'] as String?,
      placeGeoCode: json['placeGeoCode'] as String?,
    );

Map<String, dynamic> _$SavePlaceDtoToJson(SavePlaceDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'placeName': instance.placeName,
      'placeDescription': instance.placeDescription,
      'placeId': instance.placeId,
      'placeGeoCode': instance.placeGeoCode,
    };
