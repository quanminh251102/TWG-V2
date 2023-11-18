// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predictions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Predictions _$PredictionsFromJson(Map<String, dynamic> json) => Predictions(
      description: json['description'] as String?,
      matchedSubstrings: (json['matchedSubstrings'] as List<dynamic>?)
          ?.map((e) => MatchedSubstrings.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['placeId'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structuredFormatting'] == null
          ? null
          : StructuredFormatting.fromJson(
              json['structuredFormatting'] as Map<String, dynamic>),
      hasChildren: json['hasChildren'] as bool?,
      plusCode: json['plusCode'] == null
          ? null
          : PlusCode.fromJson(json['plusCode'] as Map<String, dynamic>),
      compound: json['compound'] == null
          ? null
          : Compound.fromJson(json['compound'] as Map<String, dynamic>),
      terms: (json['terms'] as List<dynamic>?)
          ?.map((e) => Terms.fromJson(e as Map<String, dynamic>))
          .toList(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'description': instance.description,
      'matchedSubstrings':
          instance.matchedSubstrings?.map((e) => e.toJson()).toList(),
      'placeId': instance.placeId,
      'reference': instance.reference,
      'structuredFormatting': instance.structuredFormatting?.toJson(),
      'hasChildren': instance.hasChildren,
      'plusCode': instance.plusCode?.toJson(),
      'compound': instance.compound?.toJson(),
      'terms': instance.terms?.map((e) => e.toJson()).toList(),
      'types': instance.types,
    };
