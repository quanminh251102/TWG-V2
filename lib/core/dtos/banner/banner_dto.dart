import 'package:json_annotation/json_annotation.dart';
part 'banner_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BannerDto {
  int? id;
  String? imagePath;

  BannerDto({this.id, this.imagePath});
  factory BannerDto.fromJson(Map<String, dynamic> json) =>
      _$BannerDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BannerDtoToJson(this);
}
