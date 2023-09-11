import 'package:json_annotation/json_annotation.dart';

part 'base_api_dto.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BaseApiDto<T> {
  T? data;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'success')
  final bool success;

  BaseApiDto({
    this.data,
    this.message,
    required this.success,
  });

  factory BaseApiDto.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseApiDtoFromJson<T>(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseApiDtoToJson<T>(this, toJsonT);
}
