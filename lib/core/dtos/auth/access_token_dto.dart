import 'package:json_annotation/json_annotation.dart';
part 'access_token_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AccessTokenDto {
  String? accsessToken;
  String? refreshToken;

  AccessTokenDto({this.accsessToken, this.refreshToken});
  factory AccessTokenDto.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenDtoToJson(this);
}
