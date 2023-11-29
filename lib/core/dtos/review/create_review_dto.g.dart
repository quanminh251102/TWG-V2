// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReviewDto _$CreateReviewDtoFromJson(Map<String, dynamic> json) =>
    CreateReviewDto(
      receiverId: json['receiverId'] as String?,
      applyId: json['applyId'] as String?,
      note: json['note'] as String?,
      star: json['star'] as int?,
    );

Map<String, dynamic> _$CreateReviewDtoToJson(CreateReviewDto instance) =>
    <String, dynamic>{
      'receiverId': instance.receiverId,
      'applyId': instance.applyId,
      'note': instance.note,
      'star': instance.star,
    };
