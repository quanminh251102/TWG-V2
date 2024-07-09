import 'dart:math';
import 'package:dialog_flowtter_plus/dialog_flowtter_plus.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/services/interfaces/igoong_service.dart';
import 'package:twg/core/view_models/interfaces/ichatbot_viewmodel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:twg/global/locator.dart';

class ChatbotViewModel with ChangeNotifier implements IChatbotViewModel {
  late DialogFlowtter _dialogFlowtter;
  final IGoongService _iGoongService = locator<IGoongService>();
  final List<Map<String, dynamic>> _messages = [];
  List<Predictions> _listPredictions = [];
  bool _onSearchPlace = false;
  @override
  List<Predictions> get listPredictions => _listPredictions;

  @override
  bool get onSearchPlace => _onSearchPlace;

  final List<types.Message> _responseMessages = [];
  latlong.LatLng? _startPoint;
  latlong.LatLng? _endPoint;

  @override
  latlong.LatLng? get startPoint => _startPoint;
  @override
  latlong.LatLng? get endPoint => _endPoint;

  LocationDto? _startPlace;
  LocationDto? _endPlace;

  @override
  LocationDto? get startPlace => _startPlace;
  @override
  LocationDto? get endPlace => _endPlace;

  @override
  set startPlace(LocationDto? value) {
    _startPlace = value;
  }

  @override
  set endPlace(LocationDto? value) {
    _endPlace = value;
  }

  @override
  Future<void> setLocationPoint(
      latlong.LatLng location, bool isStartPlace) async {
    if (isStartPlace) {
      _startPoint = location;
      addMessage(
          Message(
              text: DialogText(
                  text: ['Điểm xuất phát: ${_startPlace?.placeDescription}'])),
          true);
      DetectIntentResponse response = await _dialogFlowtter.detectIntent(
        queryInput: QueryInput(
          text: TextInput(
              text: 'Điểm xuất phát: ${_startPlace?.placeDescription}'),
        ),
      );
      if (response.message == null) return;
      for (var element in response.queryResult!.fulfillmentMessages!) {
        addMessage(element);
      }
    } else {
      _endPoint = location;
      addMessage(
          Message(
              text: DialogText(
                  text: ['Điểm đến: ${_endPlace?.placeDescription}'])),
          true);

      DetectIntentResponse response = await _dialogFlowtter.detectIntent(
        queryInput: QueryInput(
          text: TextInput(text: 'Điểm đến: ${_endPlace?.placeDescription}'),
        ),
      );
      if (response.message == null) return;
      for (var element in response.queryResult!.fulfillmentMessages!) {
        addMessage(element);
      }
      String text = '''
Tìm chuyến đi phù hợp với:
  + Điểm đi: ${_startPlace!.placeDescription}
  + Điểm đến: ${_endPlace!.placeDescription}''';
      addMessage(Message(text: DialogText(text: [text])));
      await sendMessageWithPayload();
    }
  }

  @override
  Future<PlaceDto?> getPlaceById(String locationId) async {
    return await _iGoongService.getPlaceById(locationId);
  }

  @override
  Future<void> onPickPlace(String keyWord) async {
    _listPredictions.clear();
    _onSearchPlace = true;
    notifyListeners();
    final predictions = await _iGoongService.searchPlace(keyWord);
    _listPredictions = predictions ?? [];
    _onSearchPlace = false;
    notifyListeners();
  }

  @override
  void initData() {
    _listPredictions.clear();
  }

  @override
  List<types.Message> get responseMessages => _responseMessages;

  @override
  List<Map<String, dynamic>> get message => _messages;
  String generateRandomId() {
    Random random = Random();
    int randomNumber = random.nextInt(90000000) + 10000000;
    String randomId = randomNumber.toString();
    return randomId;
  }

  @override
  Future<void> initConversation() async {
    _responseMessages.clear();
    _dialogFlowtter = await DialogFlowtter.fromFile()
        .then((instance) => _dialogFlowtter = instance);
    notifyListeners();
  }

  @override
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      addMessage(Message(text: DialogText(text: [text])), true);

      DetectIntentResponse response = await _dialogFlowtter.detectIntent(
        queryInput: QueryInput(
          text: TextInput(text: text),
        ),
      );
      if (response.message == null) return;
      for (var element in response.queryResult!.fulfillmentMessages!) {
        addMessage(element);
      }
    }
    notifyListeners();
  }

  @override
  Future<void> sendMessageWithPayload() async {
    DetectIntentResponse response = await _dialogFlowtter.detectIntent(
      queryParams: QueryParameters(
        payload: {
          'startPointLat': startPoint!.latitude,
          'startPointLong': startPoint!.longitude,
          'endPointLat': endPoint!.latitude,
          'endPointLong': endPoint!.latitude,
          'type': "from_input",
        },
      ),
      queryInput: const QueryInput(
        text: TextInput(
          text: 'Bắt đầu gợi ý',
        ),
      ),
    );
    if (response.queryResult == null) return;
    if (response.queryResult!.fulfillmentMessages![0].payload != null) {
      _responseMessages.add(
        types.CustomMessage(
          author: const types.User(
            id: 'Bot',
          ),
          createdAt: DateTime.parse(DateTime.now().toIso8601String())
              .millisecondsSinceEpoch,
          id: generateRandomId(),
          metadata: response.queryResult!.fulfillmentMessages![0].payload,
        ),
      );
    }
    notifyListeners();
  }

  @override
  void addMessage(Message message, [bool isUserMessage = false]) {
    _responseMessages.add(
      types.TextMessage(
        author: types.User(
          id: isUserMessage ? 'User' : 'Bot',
        ),
        createdAt: DateTime.parse(DateTime.now().toIso8601String())
            .millisecondsSinceEpoch,
        id: generateRandomId(),
        text: message.text?.text?[0] as String,
      ),
    );
    notifyListeners();
  }
}
