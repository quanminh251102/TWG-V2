// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleTokenDto _$GoogleTokenDtoFromJson(Map<String, dynamic> json) =>
    GoogleTokenDto(
      accsessToken: json['accsessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userEmail: json['userEmail'] as String?,
      userAvatar: json['userAvatar'] as String?,
    );

Map<String, dynamic> _$GoogleTokenDtoToJson(GoogleTokenDto instance) =>
    <String, dynamic>{
      'accsessToken': instance.accsessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userAvatar': instance.userAvatar,
    };
