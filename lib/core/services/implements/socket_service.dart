import 'package:twg/constants.dart';
import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/dtos/pagination/pagination_dto.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService implements ISocketService {
  IO.Socket? _socket;

  @override
  IO.Socket? get socket => _socket;

  @override
  Future<void> connectServer(String token) async {
    try {
      if (_socket != null) {
        _socket?.dispose();
      }

      _socket = IO.io(
        baseUrl,
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'token': token},
        ).build(),
      );
      _socket?.connect();
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
