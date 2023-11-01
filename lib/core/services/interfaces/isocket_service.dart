import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class ISocketService {
  Future<void> connectServer(String token);
  IO.Socket? get socket;
}
