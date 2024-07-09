import 'package:json_annotation/json_annotation.dart';
import 'package:twg/core/dtos/auth/address_level_dto.dart';
part 'account_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountDto {
  AddressLevelDto? address;
  int? priorityPoint;
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
  String? createdAt;
  String? updatedAt;
  int? reviewNum;
  int? applyNum;
  int? bookingNum;
  String? id;

  AccountDto({
    this.address,
    this.priorityPoint,
    this.firstName,
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
    this.createdAt,
    this.updatedAt,
    this.reviewNum,
    this.applyNum,
    this.bookingNum,
    this.id,
  });
  factory AccountDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDtoToJson(this);
}
