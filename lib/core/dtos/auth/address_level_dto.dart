import 'package:json_annotation/json_annotation.dart';
part 'address_level_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressLevelDto {
  String? level1;
  String? level2;
  String? level3;
  String? level4;

  AddressLevelDto({this.level1, this.level2, this.level3, this.level4});

  factory AddressLevelDto.fromJson(Map<String, dynamic> json) =>
      _$AddressLevelDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AddressLevelDtoToJson(this);
}
