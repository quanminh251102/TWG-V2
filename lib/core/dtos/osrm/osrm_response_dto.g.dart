// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'osrm_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionDto _$DirectionDtoFromJson(Map<String, dynamic> json) => DirectionDto(
      distance: json['distance'] as String?,
      duration: json['duration'] as String?,
      price: json['price'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DirectionDtoToJson(DirectionDto instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'price': instance.price,
      'coordinates': instance.coordinates?.map((e) => e.toJson()).toList(),
    };
