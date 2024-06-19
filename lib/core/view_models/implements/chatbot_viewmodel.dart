import 'dart:math';
import 'package:dialog_flowtter_plus/dialog_flowtter_plus.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
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

  Predictions? _startPlace;
  Predictions? _endPlace;

  @override
  Predictions? get startPlace => _startPlace;
  @override
  Predictions? get endPlace => _endPlace;
  @override
  set startPlace(Predictions? value) {
    _startPlace = value;
  }

  set endPlace(Predictions? value) {
    _endPlace = value;
  }

  @override
  void setLocationPoint(latlong.LatLng startPoint, latlong.LatLng endPoint) {
    _startPoint = startPoint;
    _endPoint = endPoint;
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
    String text = '''
Tìm chuyến đi phù hợp với:
  + Điểm đi: ${_startPlace!.description}
  + Điểm đến: ${_endPlace!.description}
''';
    addMessage(Message(text: DialogText(text: [text])), true);
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
      queryInput: QueryInput(
        text: TextInput(
          text: '',
        ),
      ),
    );
    if (response.message == null) return;
    for (var element in response.queryResult!.fulfillmentMessages!) {
      addMessage(element);
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
