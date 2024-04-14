// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterBookingDto _$FilterBookingDtoFromJson(Map<String, dynamic> json) =>
    FilterBookingDto(
      status: json['status'] as int?,
      authorId: json['authorId'] as String?,
      keyword: json['keyword'] as String?,
      bookingType: json['bookingType'] as String?,
      minPrice: json['minPrice'] as int?,
      maxPrice: json['maxPrice'] as int?,
      startAddress: json['startAddress'] as String?,
      endAddress: json['endAddress'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
    );

Map<String, dynamic> _$FilterBookingDtoToJson(FilterBookingDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'authorId': instance.authorId,
      'keyword': instance.keyword,
      'bookingType': instance.bookingType,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'startAddress': instance.startAddress,
      'endAddress': instance.endAddress,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
