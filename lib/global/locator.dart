import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get_it/get_it.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/auth/error_dto.dart';

import '../core/api/rest_client.dart';

import '../core/utils/token_utils.dart';
import 'global_data.dart';
import 'locator_dao.dart';
import 'locator_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => GlobalData());
  setupRestClient();
  registerServiceSingletons(locator);
  // await checkLogin();
}

// Future<void> checkLogin() async {
//   String? token = await TokenUtils.getToken();
//   if (token != null) {
//     try {
//       var profile = await getRestClient().getProfile(token: token);
//       if (profile.result != null) {
//         locator<GlobalData>().currentUser = profile.result!;
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//     }
//   }
// }

void setupRestClient() {
  var dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.error is SocketException) {
          EasyLoading.showError("Không có internet!");
          handler.reject(error);
        } else {
// Nếu lỗi trả về mã lỗi 401 403
          // if (error.response?.statusCode == 401 ||
          //     error.response?.statusCode == 403) {
          //Thực hiện xử lý lỗi tại đây
          var errorDetails =
              ErrorDetailsDto.fromJson(error.response?.data["error"]);
          EasyLoading.showError(errorDetails.message);
          //EasyLoading.showError("Lỗi hệ thống");
          print(errorDetails.message);
          // } else {
          // Get.snackbar("Lỗi máy chủ!", "", duration: Duration(microseconds: 700));
          //   EasyLoading.showError(errorDetails.message);
          // }
          // Chuyển tiếp lỗi cho các interceptor khác xử lý
          handler.next(error);
        }
      },
    ),
  );
  // IOHttpClientAdapter()(dio.httpClientAdapter as IOHttpClientAdapter)
  //     .onHttpClientCreate = (HttpClient client) {
  //   client.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) => true;
  //   return client;
  // };
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 15),
  );

  try {
    locator.registerLazySingleton(
      () => RestClient(dio, baseUrl: baseUrl),
      instanceName: "RestClient",
    );
  } catch (e) {
    // Future.wait([LoggerUtils.logException(e)]);
  }
}

RestClient getRestClient() {
  return locator.get<RestClient>(instanceName: 'RestClient');
}

Future<void> setDeviceSerial() async {
  String serial = '2057766';
  /*if (EnvironmentUtil.currentEnv == Environment.prod) {
    await AndroidMultipleIdentifier.requestPermission();
    serial = await AndroidMultipleIdentifier.serialCode;
    if (serial == 'unknown') {
      serial = '2057766';
    }
  } else {
    serial = '2057766';
  }*/

  // locator<GlobalData>().deviceInfo.deviceSerial = serial;
}
