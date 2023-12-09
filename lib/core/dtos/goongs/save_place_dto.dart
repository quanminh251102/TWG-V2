import 'package:json_annotation/json_annotation.dart';
part 'save_place_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SavePlaceDto {
  String? type;
  String? placeName;
  String? placeDescription;
  String? placeId;
  String? placeGeoCode;

  SavePlaceDto(
      {this.type,
      this.placeName,
      this.placeDescription,
      this.placeId,
      this.placeGeoCode});
  factory SavePlaceDto.fromJson(Map<String, dynamic> json) =>
      _$SavePlaceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SavePlaceDtoToJson(this);
}
