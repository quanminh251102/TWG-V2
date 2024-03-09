import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewDto {
  AccountDto? creater;
  AccountDto? receiver;
  ApplyInReview? apply;
  String? note;
  int? star;
  String? createdAt;
  String? updatedAt;
  String? id;

  ReviewDto(
      {this.creater,
      this.receiver,
      this.apply,
      this.note,
      this.star,
      this.createdAt,
      this.updatedAt,
      this.id});
  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);
}

class ApplyInReview {
  String? applyer;
  int? dealPrice;
  String? booking;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? id;

  ApplyInReview(
      {this.applyer,
      this.dealPrice,
      this.booking,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.id});

  ApplyInReview.fromJson(Map<String, dynamic> json) {
    applyer = json['applyer'];
    dealPrice = json['dealPrice'];
    booking = json['booking'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['applyer'] = applyer;
    data['dealPrice'] = dealPrice;
    data['booking'] = booking;
    data['state'] = state;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
