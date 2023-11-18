import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';

abstract class IHomeViewModel implements ChangeNotifier {
  Future<void> initHome();
  Position? get currentPosition;
  bool? get onSearchPlace;
  List<Predictions> get listPredictions;
  Future<void> onSearch(String keyWord);
  Future<PlaceDto?> getPlaceById(String locationId);
}
