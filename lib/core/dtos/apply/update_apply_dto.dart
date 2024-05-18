import 'package:json_annotation/json_annotation.dart';
part 'update_apply_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateApplyDto {
  String? state;

  UpdateApplyDto({
    this.state,
  });
  factory UpdateApplyDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateApplyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateApplyDtoToJson(this);
}
