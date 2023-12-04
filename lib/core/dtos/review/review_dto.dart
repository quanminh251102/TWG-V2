import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewDto {
  AccountDto? creater;
  String? applyId;
  String? note;
  int? star;
  String? createdAt;
  String? updatedAt;
  String? id;

  ReviewDto({
    this.creater,
    this.applyId,
    this.note,
    this.star,
    this.createdAt,
    this.updatedAt,
    this.id,
  });
  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);
}
