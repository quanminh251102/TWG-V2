import 'package:latlong2/latlong.dart';
import 'package:json_annotation/json_annotation.dart';
part 'osrm_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class DirectionDto {
  String? distance;
  String? duration;
  String? price;
  List<LatLng>? coordinates;

  DirectionDto({
    this.distance,
    this.duration,
    this.price,
    this.coordinates,
  });

  factory DirectionDto.fromJson(Map<String, dynamic> json) =>
      _$DirectionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DirectionDtoToJson(this);
}
