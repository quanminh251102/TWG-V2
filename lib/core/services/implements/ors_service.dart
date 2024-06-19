import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/osrm/osrm_response_dto.dart';
import 'package:twg/core/services/interfaces/iors_service.dart';
import 'package:twg/ui/utils/loading_dialog_utils.dart';

class OrsService implements IOrsService {
  getRouteUrl(String startPoint, String endPoint) {
    return '$baseOrsUrl?api_key=$apiKey&start=$startPoint&end=$endPoint';
  }

  @override
  Future<DirectionDto?> getCoordinates(
      LatLng location, LatLng destination) async {
    LoadingDialogUtils.showLoading();
    var response = await Dio().get(
      getRouteUrl(
        "${location.longitude},${location.latitude}",
        "${destination.longitude},${destination.latitude}",
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> listOfPoints = [];

      listOfPoints = response.data['features'][0]['geometry']['coordinates'];

      listOfPoints
          .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
          .toList();

      List<LatLng> coordinates = List<LatLng>.from(
        listOfPoints.map(
          (p) => LatLng(
            p[1].toDouble(),
            p[0].toDouble(),
          ),
        ),
      );

      String distance = metersToKilometers(
        response.data['features'][0]['properties']['summary']['distance'] ?? 0,
      );

      String duration = secondsToMinutes(
        response.data['features'][0]['properties']['summary']['duration'] ?? 0,
      );

      DirectionDto? directionDto = DirectionDto(
        distance: distance,
        duration: duration,
        coordinates: coordinates,
        price: calculatePrice(
          double.parse(
            (response.data['features'][0]['properties']['summary']['distance'] /
                        1000.0)
                    .toStringAsFixed(2) ??
                '0',
          ),
        ),
      );
      LoadingDialogUtils.hideLoading();
      return directionDto;
    }
    return null;
  }

  String metersToKilometers(double meters) {
    double kilometers = meters / 1000.0;
    return "${kilometers.toStringAsFixed(2)} km";
  }

  String secondsToMinutes(double seconds) {
    double minutes = seconds / 60.0;
    return "${minutes.toStringAsFixed(2)} phút";
  }

  String calculatePrice(double distanceInKm) {
    const double pricePerKm = 6000;

    double totalPrice = distanceInKm * pricePerKm;

    final NumberFormat formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'VNĐ',
    );
    return formatter.format(totalPrice);
  }
}
