import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'apply_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ApplyDto {
  AccountDto? applyer;
  int? dealPrice;
  BookingDto? booking;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? id;

  ApplyDto(
      {this.applyer,
      this.dealPrice,
      this.booking,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.id});
  factory ApplyDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ApplyDtoToJson(this);
}
