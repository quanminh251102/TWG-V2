import 'package:geolocator/geolocator.dart';

abstract class IMapService {
  Future<Position?> determinePosition();
}
