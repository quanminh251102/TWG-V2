import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
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
