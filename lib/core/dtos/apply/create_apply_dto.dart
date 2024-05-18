import 'package:json_annotation/json_annotation.dart';
part 'create_apply_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateApplyDto {
  int? dealPrice;
  String? booking;

  CreateApplyDto({
    this.dealPrice,
    this.booking,
  });
  factory CreateApplyDto.fromJson(Map<String, dynamic> json) =>
      _$CreateApplyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateApplyDtoToJson(this);
}
