import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/pagination/pagination_dto.dart';

abstract class ISocketService {
  Future<void> connectServer(String token);
  IO.Socket? get socket;
}
