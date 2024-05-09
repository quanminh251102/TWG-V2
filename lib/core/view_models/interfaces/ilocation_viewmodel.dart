import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';

abstract class ILocationViewModel implements ChangeNotifier {
  List<LocationDto> get savedLocation;
  LatLng? get startPointGeo;
  LatLng? get endPointGeo;
  Future<void> getSavedLocation();
  void updateRecommendLocation(LatLng? startPointGeo, LatLng? endPointGeo);
}
