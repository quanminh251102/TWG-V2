import 'package:twg/core/dtos/auth/account_dto.dart';

class GlobalData {
  // GlobalData() {
  //   deviceInfo = DeviceInfo();
  // }

  DeviceInfo deviceInfo = DeviceInfo();
  AccountInfo accountInfo = AccountInfo();
  AccountInfo newAccount = AccountInfo();
  String token = '';
  late String logLevel;
  AccountDto? currentUser;
  // AccessToken? token;
}

// TODO: remove fake data
class DeviceInfo {
  late String deviceSerial;
  late String id;
  late String deviceId;
  late String branchId;
  String branchName = 'BigC';
  late bool isTraining;
  late bool saleDiscount;
  String userName = 'Thế Lữ';
  late String branchCode;
}

class AccountInfo {
  String userName = 'Thế Lữ';
  String phoneNumber = '0782454274';
  int deviceId = 1;
}
