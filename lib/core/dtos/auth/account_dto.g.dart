// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDto _$AccountDtoFromJson(Map<String, dynamic> json) => AccountDto(
      address: json['address'] == null
          ? null
          : AddressLevelDto.fromJson(json['address'] as Map<String, dynamic>),
      priorityPoint: json['priorityPoint'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      online: json['online'] as bool?,
      gender: json['gender'] as String?,
      locationId: json['locationId'] as String?,
      locationMainText: json['locationMainText'] as String?,
      locationAddress: json['locationAddress'] as String?,
      role: json['role'] as String?,
      isCalling: json['isCalling'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AccountDtoToJson(AccountDto instance) =>
    <String, dynamic>{
      'address': instance.address?.toJson(),
      'priorityPoint': instance.priorityPoint,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'avatarUrl': instance.avatarUrl,
      'phoneNumber': instance.phoneNumber,
      'online': instance.online,
      'gender': instance.gender,
      'locationId': instance.locationId,
      'locationMainText': instance.locationMainText,
      'locationAddress': instance.locationAddress,
      'role': instance.role,
      'isCalling': instance.isCalling,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };
