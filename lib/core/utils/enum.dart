import 'package:json_annotation/json_annotation.dart';

part 'enum_helper.dart';

enum CustomNavigationBar {
  @JsonValue(0)
  home,
  @JsonValue(1)
  booking,
  @JsonValue(2)
  chat,
  @JsonValue(3)
  account,
}

enum BookingType {
  @JsonValue(0)
  findDriver,
  @JsonValue(1)
  findPassenger,
}

enum SavePlaceType {
  @JsonValue(0)
  home,
  @JsonValue(1)
  company,
  @JsonValue(2)
  other,
}

enum BookingStatus {
  @JsonValue(2)
  available,
  @JsonValue(1)
  complete,
}
