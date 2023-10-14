import 'package:json_annotation/json_annotation.dart';
part 'access_token_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AccessTokenDto {
  String? accsess_token;
  String? refresh_token;

  AccessTokenDto({this.accsess_token, this.refresh_token});
  factory AccessTokenDto.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenDtoToJson(this);
}
