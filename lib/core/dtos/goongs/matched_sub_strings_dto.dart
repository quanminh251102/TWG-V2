import 'package:json_annotation/json_annotation.dart';

part 'matched_sub_strings_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchedSubstrings {
  int? length;
  int? offset;

  MatchedSubstrings({this.length, this.offset});
  factory MatchedSubstrings.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringsFromJson(json);
  Map<String, dynamic> toJson() => _$MatchedSubstringsToJson(this);
}
