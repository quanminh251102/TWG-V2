import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twg/core/dtos/auth/address_level_dto.dart';
part 'booking_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingDto {
  AccountDto? authorId;
  int? status;
  double? price;
  String? bookingType;
  String? time;
  String? content;
  double? startPointLat;
  double? startPointLong;
  String? startPointId;
  String? startPointMainText;
  String? startPointAddress;
  double? endPointLat;
  double? endPointLong;
  String? endPointId;
  String? endPointMainText;
  String? endPointAddress;
  String? distance;
  String? duration;
  int? point;
  List<String>? userFavorites;
  List<String>? userMayFavorites;
  int? applyNum;
  int? watchedNum;
  int? savedNum;
  double? diftAtribute;
  bool? isNew;
  double? interesestValue;
  double? interesestConfidenceValue;
  bool? isReal;
  bool? isCaseBased;
  bool? isFavorite;
  bool? isMayFavorite;
  String? createdAt;
  String? updatedAt;
  String? id;
  BookingDto(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.authorId,
      this.status,
      this.price,
      this.bookingType,
      this.time,
      this.content,
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
      this.point,
      this.userFavorites,
      this.userMayFavorites,
      this.applyNum,
      this.watchedNum,
      this.savedNum,
      this.diftAtribute,
      this.isNew,
      this.interesestValue,
      this.interesestConfidenceValue,
      this.isReal,
      this.isCaseBased,
      this.isFavorite,
      this.isMayFavorite});

  factory BookingDto.fromJson(Map<String, dynamic> json) =>
      _$BookingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingDtoToJson(this);
}
