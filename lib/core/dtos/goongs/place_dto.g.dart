// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDto _$PlaceDtoFromJson(Map<String, dynamic> json) => PlaceDto(
      placeId: json['placeId'] as String?,
      formattedAddress: json['formattedAddress'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PlaceDtoToJson(PlaceDto instance) => <String, dynamic>{
      'placeId': instance.placeId,
      'formattedAddress': instance.formattedAddress,
      'geometry': instance.geometry?.toJson(),
      'name': instance.name,
    };
