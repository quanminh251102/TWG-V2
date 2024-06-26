import 'package:json_annotation/json_annotation.dart';
part 'google_token_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleTokenDto {
  String? accsessToken;
  String? refreshToken;
  String? userId;
  String? userName;
  String? userEmail;
  String? userAvatar;

  GoogleTokenDto(
      {this.accsessToken,
      this.refreshToken,
      this.userId,
      this.userName,
      this.userEmail,
      this.userAvatar});
  factory GoogleTokenDto.fromJson(Map<String, dynamic> json) =>
      _$GoogleTokenDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleTokenDtoToJson(this);
}
