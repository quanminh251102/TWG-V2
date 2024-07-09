import 'package:json_annotation/json_annotation.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';

part 'location_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationDto {
  String? type;
  String? placeName;
  String? placeDescription;
  String? placeId;
  String? placeGeoCode;

  LocationDto(
      {this.type,
      this.placeName,
      this.placeDescription,
      this.placeId,
      this.placeGeoCode});
  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
