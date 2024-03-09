// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) => ReviewDto(
      creater: json['creater'] == null
          ? null
          : AccountDto.fromJson(json['creater'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : AccountDto.fromJson(json['receiver'] as Map<String, dynamic>),
      apply: json['apply'] == null
          ? null
          : ApplyInReview.fromJson(json['apply'] as Map<String, dynamic>),
      note: json['note'] as String?,
      star: json['star'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ReviewDtoToJson(ReviewDto instance) => <String, dynamic>{
      'creater': instance.creater?.toJson(),
      'receiver': instance.receiver?.toJson(),
      'apply': instance.apply?.toJson(),
      'note': instance.note,
      'star': instance.star,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };
