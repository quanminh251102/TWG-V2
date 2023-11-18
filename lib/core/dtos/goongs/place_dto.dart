import 'package:json_annotation/json_annotation.dart';

part 'place_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaceDto {
  String? placeId;
  String? formattedAddress;
  Geometry? geometry;
  String? name;

  PlaceDto({this.placeId, this.formattedAddress, this.geometry, this.name});

  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceDtoToJson(this);
}

class Geometry {
  Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
