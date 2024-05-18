import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/osrm/osrm_response_dto.dart';

abstract class IOrsService {
  Future<DirectionDto?> getCoordinates(LatLng location, LatLng destination);
}
