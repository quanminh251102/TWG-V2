import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/services/interfaces/ilocation_service.dart';
import 'package:twg/core/view_models/interfaces/ilocation_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

class LocationViewModel with ChangeNotifier implements ILocationViewModel {
  ILocationService _iLocationService = locator<ILocationService>();
  List<LocationDto> _savedLocation = [];
  LatLng? _startPointGeo;
  LatLng? _endPointGeo;

  @override
  LatLng? get startPointGeo => _startPointGeo;
  @override
  LatLng? get endPointGeo => _endPointGeo;

  @override
  List<LocationDto> get savedLocation => _savedLocation;
  @override
  Future<void> getSavedLocation() async {
    _savedLocation = [];
    var result = await _iLocationService.getSaveLocation();
    if (result != null) {
      _savedLocation = result;
    }
    notifyListeners();
  }

  @override
  void updateRecommendLocation(LatLng? startPointGeo, LatLng? endPointGeo) {
    _startPointGeo = startPointGeo;
    _endPointGeo = endPointGeo;
  }
}
