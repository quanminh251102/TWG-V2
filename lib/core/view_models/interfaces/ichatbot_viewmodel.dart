import 'package:dialog_flowtter_plus/dialog_flowtter_plus.dart'
    as dialog_flowtter_plus;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';

abstract class IChatbotViewModel implements ChangeNotifier {
  List<Map<String, dynamic>> get message;
  List<types.Message> get responseMessages;
  bool get onSearchPlace;
  List<Predictions> get listPredictions;
  LatLng? get startPoint;
  LatLng? get endPoint;
  LocationDto? get startPlace;
  set startPlace(LocationDto? value);
  set endPlace(LocationDto? value);
  LocationDto? get endPlace;
  Future<void> setLocationPoint(LatLng location, bool isStartPlace);
  Future<void> initConversation();
  void initData();
  Future<void> sendMessage(String text);
  Future<void> sendMessageWithPayload();
  void addMessage(dialog_flowtter_plus.Message message,
      [bool isUserMessage = false]);
  Future<void> onPickPlace(String keyWord);
  Future<PlaceDto?> getPlaceById(String locationId);
}
