import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_review_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateReviewDto {
  String? receiverId;
  String? applyId;
  String? note;
  int? star;

  CreateReviewDto({
    this.receiverId,
    this.applyId,
    this.note,
    this.star,
  });
  factory CreateReviewDto.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateReviewDtoToJson(this);
}
