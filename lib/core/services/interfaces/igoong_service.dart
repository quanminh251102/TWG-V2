import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';

abstract class IGoongService {
  Future<List<Predictions>?> searchPlace(String keyWord);
  Future<PlaceDto?> getPlaceById(String locationId);
  Future<List<PlaceDetailDto>?> getPlaceByGeocode(LatLng latLng);
}
