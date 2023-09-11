import 'package:json_annotation/json_annotation.dart';

part 'enum_helper.dart';

enum CustomNavigationBar {
  @JsonValue(0)
  live,
  @JsonValue(1)
  news,
  @JsonValue(2)
  tournament,
  @JsonValue(3)
  follow,
  @JsonValue(4)
  account,
}

enum HomeNavigationBar {
  @JsonValue(0)
  home,
  @JsonValue(1)
  football,
  @JsonValue(2)
  basketball,
  @JsonValue(3)
  result,
}

enum LiveNavigationBar {
  @JsonValue(0)
  chat,
  @JsonValue(1)
  commentator,
  @JsonValue(2)
  rankings,
  @JsonValue(3)
  liveSchedule,
}

enum ScheduleNavigationBar {
  @JsonValue(0)
  home,
  @JsonValue(1)
  football,
  @JsonValue(2)
  basketball,
}

enum ScheduleTabBar {
  @JsonValue(0)
  result,
  @JsonValue(1)
  live,
  @JsonValue(2)
  schedule,
}

enum Sport {
  @JsonValue(0)
  football,
  @JsonValue(1)
  basketball,
}

enum EventAction {
  @JsonValue(0)
  goal,
  @JsonValue(1)
  card,
  @JsonValue(2)
  subst,
  @JsonValue(3)
  check,
}
