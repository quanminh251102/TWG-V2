import 'package:json_annotation/json_annotation.dart';
part 'account_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountDto {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? avatarUrl;
  String? phoneNumber;
  bool? online;
  String? gender;
  String? locationId;
  String? locationMainText;
  String? locationAddress;
  String? role;
  bool? isCalling;
  String? id;

  AccountDto(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.avatarUrl,
      this.phoneNumber,
      this.online,
      this.gender,
      this.locationId,
      this.locationMainText,
      this.locationAddress,
      this.role,
      this.isCalling,
      this.id});
  factory AccountDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDtoToJson(this);
}
