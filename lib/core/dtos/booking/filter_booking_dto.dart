// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';


part 'filter_booking_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterBookingDto {
  int? status;
  String? authorId;
  String? keyword;
  String? bookingType;
  int? minPrice;
  int? maxPrice;
  String? startAddress;
  String? endAddress;
  String? startTime;
  String? endTime;
  FilterBookingDto({
    this.status,
    this.authorId,
    this.keyword,
    this.bookingType,
    this.minPrice,
    this.maxPrice,
    this.startAddress,
    this.endAddress,
    this.startTime,
    this.endTime,
  });

  factory FilterBookingDto.fromJson(Map<String, dynamic> json) =>
      _$FilterBookingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FilterBookingDtoToJson(this);
}
