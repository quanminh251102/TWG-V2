import 'package:twg/core/dtos/location/location_dto.dart';

abstract class ILocationService {
  Future<List<LocationDto>?> getSaveLocation({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  });
}
