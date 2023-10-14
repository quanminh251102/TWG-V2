import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingDto {
  String? id;
  AccountDto? authorId;
  String? status;
  int? price;
  String? bookingType;
  String? time;
  String? startPointLat;
  String? startPointLong;
  String? startPointId;
  String? startPointMainText;
  String? startPointAddress;
  String? endPointLat;
  String? endPointLong;
  String? endPointId;
  String? endPointMainText;
  String? endPointAddress;
  String? distance;
  String? duration;
  String? createdAt;
  String? updatedAt;
  String? content;
  BookingDto({
    this.id,
    this.authorId,
    this.status,
    this.price,
    this.bookingType,
    this.time,
    this.startPointLat,
    this.startPointLong,
    this.startPointId,
    this.startPointMainText,
    this.startPointAddress,
    this.endPointLat,
    this.endPointLong,
    this.endPointId,
    this.endPointMainText,
    this.endPointAddress,
    this.distance,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.content,
  });
  factory BookingDto.fromJson(Map<String, dynamic> json) =>
      _$BookingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingDtoToJson(this);
}
