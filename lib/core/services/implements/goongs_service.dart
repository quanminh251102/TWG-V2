import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/goongs/search_response_dto.dart';
import 'package:twg/core/services/interfaces/igoong_service.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

class GoongService implements IGoongService {
  @override
  Future<List<Predictions>?> searchPlace(String keyWord) async {
    try {
      var result = await Dio().get(
        '$baseGoongsUrl/Place/AutoComplete?api_key=$goongKey&location=${locator<GlobalData>().currentPosition!.latitude},%20${locator<GlobalData>().currentPosition!.longitude}&input=$keyWord',
      );

      if (result.statusCode == 200) {
        SearchResponse searchResponse = SearchResponse.fromJson(result.data);
        return searchResponse.predictions;
      }
    } on Exception catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Future<PlaceDto?> getPlaceById(String locationId) async {
    try {
      var result = await Dio().get(
        '$baseGoongsUrl/Place/Detail?place_id=$locationId&api_key=$goongKey',
      );

      if (result.statusCode == 200) {
        PlaceDto placeDto = PlaceDto.fromJson(result.data['result']);
        return placeDto;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}