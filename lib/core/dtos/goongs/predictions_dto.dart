import 'package:json_annotation/json_annotation.dart';
import 'package:twg/core/dtos/goongs/matched_sub_strings_dto.dart';
import 'package:twg/core/dtos/goongs/search_response_dto.dart';
import 'package:twg/core/dtos/goongs/structured_formatting_dto.dart';
part 'predictions_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class Predictions {
  String? description;
  List<MatchedSubstrings>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  bool? hasChildren;
  PlusCode? plusCode;
  Compound? compound;
  List<Terms>? terms;
  List<String>? types;

  Predictions({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.hasChildren,
    this.plusCode,
    this.compound,
    this.terms,
    this.types,
  });
  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['matched_substrings'] != null) {
      matchedSubstrings = <MatchedSubstrings>[];
      json['matched_substrings'].forEach((v) {
        matchedSubstrings!.add(MatchedSubstrings.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? StructuredFormatting.fromJson(json['structured_formatting'])
        : null;
    hasChildren = json['has_children'];
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    compound =
        json['compound'] != null ? Compound.fromJson(json['compound']) : null;
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(Terms.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (matchedSubstrings != null) {
      data['matched_substrings'] =
          matchedSubstrings!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = placeId;
    data['reference'] = reference;
    if (structuredFormatting != null) {
      data['structured_formatting'] = structuredFormatting!.toJson();
    }
    data['has_children'] = hasChildren;
    if (plusCode != null) {
      data['plus_code'] = plusCode!.toJson();
    }
    if (compound != null) {
      data['compound'] = compound!.toJson();
    }
    if (terms != null) {
      data['terms'] = terms!.map((v) => v.toJson()).toList();
    }
    data['types'] = types;
    return data;
  }
}
