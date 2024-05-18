import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/goongs/search_response_dto.dart';
import 'package:twg/core/services/interfaces/igoong_service.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/utils/loading_dialog_utils.dart';

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
    LoadingDialogUtils.showLoading();
    try {
      var result = await Dio().get(
        '$baseGoongsUrl/Place/Detail?place_id=$locationId&api_key=$goongKey',
      );
      if (result.statusCode == 200) {
        PlaceDto placeDto = PlaceDto.fromJson(result.data['result']);
        LoadingDialogUtils.hideLoading();
        return placeDto;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<List<PlaceDetailDto>?> getPlaceByGeocode(LatLng latLng) async {
    try {
      var result = await Dio().get(
        '$baseGoongsUrl/Geocode?latlng=${latLng.latitude},%20${latLng.longitude}&api_key=$goongKey',
      );
      if (result.statusCode == 200) {
        List<PlaceDetailDto> placeDetailDto = [];
        for (var place in result.data['results']) {
          placeDetailDto.add(PlaceDetailDto.fromJson(place));
        }
        return placeDetailDto;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
