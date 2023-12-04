// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyDto _$ApplyDtoFromJson(Map<String, dynamic> json) => ApplyDto(
      applyer: json['applyer'] == null
          ? null
          : AccountDto.fromJson(json['applyer'] as Map<String, dynamic>),
      dealPrice: json['dealPrice'] as int?,
      booking: json['booking'] == null
          ? null
          : BookingDto.fromJson(json['booking'] as Map<String, dynamic>),
      state: json['state'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ApplyDtoToJson(ApplyDto instance) => <String, dynamic>{
      'applyer': instance.applyer?.toJson(),
      'dealPrice': instance.dealPrice,
      'booking': instance.booking?.toJson(),
      'state': instance.state,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };
