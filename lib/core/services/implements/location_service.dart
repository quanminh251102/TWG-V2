import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/services/interfaces/ilocation_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class LocationService implements ILocationService {
  @override
  Future<List<LocationDto>?> getSaveLocation({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getLocationByUser(
        token: token,
        page: page,
        pageSize: pageSize,
      );

      if (result.success) {
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
