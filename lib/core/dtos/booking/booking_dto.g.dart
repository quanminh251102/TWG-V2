// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDto _$BookingDtoFromJson(Map<String, dynamic> json) => BookingDto(
      id: json['id'] as String?,
      authorId: json['authorId'] == null
          ? null
          : AccountDto.fromJson(json['authorId'] as Map<String, dynamic>),
      status: json['status'] as String?,
      price: json['price'] as int?,
      bookingType: json['bookingType'] as String?,
      time: json['time'] as String?,
      startPointLat: json['startPointLat'] as String?,
      startPointLong: json['startPointLong'] as String?,
      startPointId: json['startPointId'] as String?,
      startPointMainText: json['startPointMainText'] as String?,
      startPointAddress: json['startPointAddress'] as String?,
      endPointLat: json['endPointLat'] as String?,
      endPointLong: json['endPointLong'] as String?,
      endPointId: json['endPointId'] as String?,
      endPointMainText: json['endPointMainText'] as String?,
      endPointAddress: json['endPointAddress'] as String?,
      distance: json['distance'] as String?,
      duration: json['duration'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$BookingDtoToJson(BookingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId?.toJson(),
      'status': instance.status,
      'price': instance.price,
      'bookingType': instance.bookingType,
      'time': instance.time,
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
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'content': instance.content,
    };
