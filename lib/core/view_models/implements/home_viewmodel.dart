import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/services/interfaces/igoong_service.dart';
import 'package:twg/core/services/interfaces/imap_service.dart';
import 'package:twg/core/view_models/interfaces/ihome_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

class HomeViewModel extends ChangeNotifier implements IHomeViewModel {
  Position? _currentPosition;

  final IMapService _iMapService = locator<IMapService>();
  final IBookingService _iBookingService = locator<IBookingService>();
  final IGoongService _iGoongService = locator<IGoongService>();

  final bool _onSearchPlace = false;
  List<Predictions> _listPredictions = [];

  @override
  List<Predictions> get listPredictions => _listPredictions;

  @override
  Position? get currentPosition => _currentPosition;

  @override
  bool? get onSearchPlace => _onSearchPlace;

  @override
  Future<void> initHome() async {
    _currentPosition = await _iMapService.determinePosition();
    locator<GlobalData>().currentPosition = _currentPosition;
    notifyListeners();
  }

  @override
  Future<List<Predictions>> onSearch(String keyWord) async {
    _listPredictions.clear();
    final predictions = await _iGoongService.searchPlace(keyWord);
    _listPredictions = predictions ?? [];
    notifyListeners();
    return _listPredictions;
  }

  @override
  Future<PlaceDto?> getPlaceById(String locationId) async {
    return await _iGoongService.getPlaceById(locationId);
  }
}
