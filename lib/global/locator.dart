import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get_it/get_it.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/auth/error_dto.dart';
import 'package:twg/core/dtos/base_api_dto.dart';

import '../core/api/rest_client.dart';

import '../core/utils/token_utils.dart';
import 'global_data.dart';
import 'locator_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => GlobalData());
  setupRestClient();
  registerServiceSingletons(locator);
}

void setupRestClient() {
  var dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.error is SocketException) {
          await EasyLoading.showError("Không có internet!");
          handler.reject(error);
        } else {
          if (error.response?.statusCode == 400) {
            var errorDetails = ErrorDetailsDto.fromJson(error.response?.data);

            await EasyLoading.showError(errorDetails.message,
                duration: const Duration(seconds: 3));
            handler.reject(error);
          } else if (error.response?.statusCode == 500) {
            await EasyLoading.showError('Lỗi server');
            handler.reject(error);
          } else {
            // Nếu lỗi trả về mã lỗi 401 403
            // if (error.response?.statusCode == 401 ||
            //     error.response?.statusCode == 403) {
            //Thực hiện xử lý lỗi tại đây
            var errorDetails =
                ErrorDetailsDto.fromJson(error.response?.data["error"]);
            await EasyLoading.showError(errorDetails.message);
            //EasyLoading.showError("Lỗi hệ thống");

            // } else {
            // Get.snackbar("Lỗi máy chủ!", "", duration: Duration(microseconds: 700));
            //   EasyLoading.showError(errorDetails.message);
            // }
            // Chuyển tiếp lỗi cho các interceptor khác xử lý
            handler.next(error);
          }
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
