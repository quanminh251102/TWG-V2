import 'package:json_annotation/json_annotation.dart';
part 'call_info_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CallInfoDto {
  String? id;
  String? callerId;
  String? receiverId;
  String? callerName;
  String? receiverName;
  String? callerAvatar;
  String? receiverAvatar;
  bool? isCaller;

  CallInfoDto({
    this.id,
    this.callerId,
    this.receiverId,
    this.callerName,
    this.receiverName,
    this.callerAvatar,
    this.receiverAvatar,
    this.isCaller,
  });
  factory CallInfoDto.fromJson(Map<String, dynamic> json) =>
      _$CallInfoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CallInfoDtoToJson(this);
}
