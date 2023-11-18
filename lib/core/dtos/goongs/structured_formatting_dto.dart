import 'package:json_annotation/json_annotation.dart';
part 'structured_formatting_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class StructuredFormatting {
  String? mainText;
  String? secondaryText;

  StructuredFormatting({
    this.mainText,
    this.secondaryText,
  });
  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);
  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}
