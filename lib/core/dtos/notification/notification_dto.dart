import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationDto {
  AccountDto? receiver;
  AccountDto? author;
  String? text;
  String? createdAt;
  String? updatedAt;
  String? id;

  NotificationDto(
      {this.receiver,
      this.author,
      this.text,
      this.createdAt,
      this.updatedAt,
      this.id});
  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);
}
