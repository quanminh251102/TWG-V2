// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDto _$BookingDtoFromJson(Map<String, dynamic> json) => BookingDto(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      authorId: json['authorId'] == null
          ? null
          : AccountDto.fromJson(json['authorId'] as Map<String, dynamic>),
      status: json['status'] as int?,
      price: (json['price'] as num?)?.toDouble(),
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
      userFavorites: (json['userFavorites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userMayFavorites: (json['userMayFavorites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      applyNum: json['applyNum'] as int?,
      watchedNum: json['watchedNum'] as int?,
      savedNum: json['savedNum'] as int?,
      diftAtribute: (json['diftAtribute'] as num?)?.toDouble(),
      isNew: json['isNew'] as bool?,
      interesestValue: (json['interesestValue'] as num?)?.toDouble(),
      interesestConfidenceValue:
          (json['interesestConfidenceValue'] as num?)?.toDouble(),
      isReal: json['isReal'] as bool?,
      isCaseBased: json['isCaseBased'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
      isMayFavorite: json['isMayFavorite'] as bool?,
    );

Map<String, dynamic> _$BookingDtoToJson(BookingDto instance) =>
    <String, dynamic>{
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
      'userFavorites': instance.userFavorites,
      'userMayFavorites': instance.userMayFavorites,
      'applyNum': instance.applyNum,
      'watchedNum': instance.watchedNum,
      'savedNum': instance.savedNum,
      'diftAtribute': instance.diftAtribute,
      'isNew': instance.isNew,
      'interesestValue': instance.interesestValue,
      'interesestConfidenceValue': instance.interesestConfidenceValue,
      'isReal': instance.isReal,
      'isCaseBased': instance.isCaseBased,
      'isFavorite': instance.isFavorite,
      'isMayFavorite': instance.isMayFavorite,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };
