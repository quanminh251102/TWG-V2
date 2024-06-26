part of 'enum.dart';

/// Workaround to achieve enum with value (like in `C#`)
class EnumHelper {
  static int getValue<T>(Map<T, MyEnum> enumMap, T myEnum) {
    if (myEnum == null) {
      return -2;
    }

    return enumMap[myEnum]!.value;
  }

  static String getDescription<T>(Map<T, MyEnum> enumMap, T myEnum) {
    if (myEnum == null) {
      return '';
    }

    return enumMap[myEnum]!.description;
  }

  static T getEnum<T>(Map<T, MyEnum> enumMap, int value) {
    return enumMap.keys.firstWhere(
      (key) => enumMap[key]!.value == value,
      // orElse: () => null,
    );
  }

  static T getEnumFromDescription<T>(
      Map<T, MyEnum> enumMap, String description) {
    return enumMap.keys.firstWhere(
      (key) => enumMap[key]!.description == description,
      // orElse: () => null,
    );
  }
}

class MyEnum {
  late int value;
  late String description;

  MyEnum({required this.value, required this.description});
}

class EnumMap {
  static Map<CustomNavigationBar, MyEnum> navigationBarValue = {
    CustomNavigationBar.home: MyEnum(value: 0, description: 'Trang chủ'),
    CustomNavigationBar.booking: MyEnum(value: 1, description: 'Chuyến đi'),
    CustomNavigationBar.chat: MyEnum(value: 2, description: 'Trò chuyện'),
    CustomNavigationBar.account: MyEnum(value: 3, description: 'Cá nhân'),
  };

  static Map<BookingType, MyEnum> bookingType = {
    BookingType.findDriver: MyEnum(value: 0, description: 'Tìm tài xế'),
    BookingType.findPassenger: MyEnum(value: 1, description: 'Tìm hành khách'),
  };
  static Map<SavePlaceType, MyEnum> savePlaceType = {
    SavePlaceType.home: MyEnum(value: 0, description: 'nhà'),
    SavePlaceType.school: MyEnum(value: 1, description: 'trường học'),
    SavePlaceType.other: MyEnum(value: 2, description: 'địa điểm'),
  };
  static Map<BookingStatus, MyEnum> bookingStatus = {
    BookingStatus.available: MyEnum(value: 2, description: 'Sẵn sàng'),
    BookingStatus.complete: MyEnum(value: 1, description: 'Hoàn thành'),
  };
}
