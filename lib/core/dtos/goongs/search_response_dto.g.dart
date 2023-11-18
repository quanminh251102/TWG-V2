// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      predictions: (json['predictions'] as List<dynamic>?)
          ?.map((e) => Predictions.fromJson(e as Map<String, dynamic>))
          .toList(),
      executionTime: json['executionTime'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'predictions': instance.predictions?.map((e) => e.toJson()).toList(),
      'executionTime': instance.executionTime,
      'status': instance.status,
    };
