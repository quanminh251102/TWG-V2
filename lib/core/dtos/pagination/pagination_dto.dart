import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class PaginationDto<T> {
  List<T>? items;

  PaginationDto({
    this.items,
  });

  factory PaginationDto.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationDtoFromJson<T>(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginationDtoToJson<T>(this, toJsonT);
}
