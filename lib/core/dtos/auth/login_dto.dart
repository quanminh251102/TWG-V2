import 'package:json_annotation/json_annotation.dart';
part 'login_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginDto {
  final String email;
  final String password;
  String? avatar;
  LoginDto({required this.email, required this.password, this.avatar});

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
