// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'base_api_dto.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BaseApiDto<T> {
  T? data;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'total')
  int? total;
  BaseApiDto({
    this.data,
    this.message,
    required this.success,
    this.total,
  });

  factory BaseApiDto.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseApiDtoFromJson<T>(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseApiDtoToJson<T>(this, toJsonT);
}
