import 'package:json_annotation/json_annotation.dart';
part 'error_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorDetailsDto {
  final int code;
  final String message;
  final String? details;
  // @JsonKey(name: 'validationErrors')
  // final dynamic validationErrors;

  ErrorDetailsDto({
    required this.code,
    required this.message,
    this.details,
    // this.validationErrors,
  });

  factory ErrorDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorDetailsDtoToJson(this);
}
