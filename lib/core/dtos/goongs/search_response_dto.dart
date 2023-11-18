import 'package:json_annotation/json_annotation.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
part 'search_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponse {
  List<Predictions>? predictions;
  String? executionTime;
  String? status;

  SearchResponse({this.predictions, this.executionTime, this.status});
  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['compound_code'] = compoundCode;
    data['global_code'] = globalCode;
    return data;
  }
}

class Compound {
  String? district;
  String? commune;
  String? province;

  Compound({this.district, this.commune, this.province});

  Compound.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    commune = json['commune'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district'] = district;
    data['commune'] = commune;
    data['province'] = province;
    return data;
  }
}

class Terms {
  int? offset;
  String? value;

  Terms({this.offset, this.value});

  Terms.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['value'] = value;
    return data;
  }
}
