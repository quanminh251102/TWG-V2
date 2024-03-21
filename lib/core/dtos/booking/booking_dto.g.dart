// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDto _$BookingDtoFromJson(Map<String, dynamic> json) => BookingDto(
      startAddress: json['startAddress'] == null
          ? null
          : AddressLevelDto.fromJson(
              json['startAddress'] as Map<String, dynamic>),
      endAddress: json['endAddress'] == null
          ? null
          : AddressLevelDto.fromJson(
              json['endAddress'] as Map<String, dynamic>),
      authorId: json['authorId'] == null
          ? null
          : AccountDto.fromJson(json['authorId'] as Map<String, dynamic>),
      status: json['status'] as int?,
      price: json['price'] as int?,
      bookingType: json['bookingType'] as String?,
      time: json['time'] as String?,
      content: json['content'] as String?,
      startPointLat: (json['startPointLat'] as num?)?.toDouble(),
      startPointLong: (json['startPointLong'] as num?)?.toDouble(),
      startPointId: json['startPointId'] as String?,
      startPointMainText: json['startPointMainText'] as String?,
      startPointAddress: json['startPointAddress'] as String?,
      endPointLat: (json['endPointLat'] as num?)?.toDouble(),
      endPointLong: (json['endPointLong'] as num?)?.toDouble(),
      endPointId: json['endPointId'] as String?,
      endPointMainText: json['endPointMainText'] as String?,
      endPointAddress: json['endPointAddress'] as String?,
      distance: json['distance'] as String?,
      duration: json['duration'] as String?,
      point: json['point'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BookingDtoToJson(BookingDto instance) =>
    <String, dynamic>{
      'startAddress': instance.startAddress?.toJson(),
      'endAddress': instance.endAddress?.toJson(),
      'authorId': instance.authorId?.toJson(),
      'status': instance.status,
      'price': instance.price,
      'bookingType': instance.bookingType,
      'time': instance.time,
      'content': instance.content,
      'startPointLat': instance.startPointLat,
      'startPointLong': instance.startPointLong,
      'startPointId': instance.startPointId,
      'startPointMainText': instance.startPointMainText,
      'startPointAddress': instance.startPointAddress,
      'endPointLat': instance.endPointLat,
      'endPointLong': instance.endPointLong,
      'endPointId': instance.endPointId,
      'endPointMainText': instance.endPointMainText,
      'endPointAddress': instance.endPointAddress,
      'distance': instance.distance,
      'duration': instance.duration,
      'point': instance.point,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };
