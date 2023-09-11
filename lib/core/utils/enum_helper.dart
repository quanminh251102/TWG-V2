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
    CustomNavigationBar.live: MyEnum(value: 0, description: 'Live'),
    CustomNavigationBar.news: MyEnum(value: 1, description: 'News'),
    CustomNavigationBar.tournament: MyEnum(value: 2, description: 'Chat'),
    CustomNavigationBar.follow: MyEnum(value: 3, description: 'Follow'),
    CustomNavigationBar.account: MyEnum(value: 3, description: 'Account'),
  };
  static Map<HomeNavigationBar, MyEnum> homeNavigationBarValue = {
    HomeNavigationBar.home: MyEnum(value: 0, description: 'Home'),
    HomeNavigationBar.football: MyEnum(value: 1, description: 'Football'),
    HomeNavigationBar.basketball: MyEnum(value: 2, description: 'Basketball'),
    HomeNavigationBar.result: MyEnum(value: 3, description: 'Result'),
  };
  static Map<ScheduleTabBar, MyEnum> scheduleTabBar = {
    ScheduleTabBar.result: MyEnum(value: 0, description: 'Result'),
    ScheduleTabBar.live: MyEnum(value: 1, description: 'Live'),
    ScheduleTabBar.schedule: MyEnum(value: 2, description: 'Schedule'),
  };
  static Map<EventAction, MyEnum> event = {
    EventAction.goal: MyEnum(value: 0, description: 'Goal'),
    EventAction.card: MyEnum(value: 1, description: 'Card'),
    EventAction.subst: MyEnum(value: 2, description: 'subst'),
    EventAction.check: MyEnum(value: 3, description: 'Var'),
  };
}
