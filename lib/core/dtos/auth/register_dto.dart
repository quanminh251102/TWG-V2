import 'package:json_annotation/json_annotation.dart';
part 'register_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterDto {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  RegisterDto({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}
