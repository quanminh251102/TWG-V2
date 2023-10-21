import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:hoangduc/translation/strings.dart';
import 'package:provider/provider.dart';
import 'package:twg/ui/utils/navigation_utils.dart';
import 'core/utils/color_utils.dart';
import 'global/locator.dart';
import 'global/providers.dart';
import 'global/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  configLoading();
  await setupLocator();
  runApp(const MyApp());
}

Future<void> mainDelegate() async {}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [...viewModelProviders],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return GetMaterialApp(
              builder: EasyLoading.init(),
              title: 'TWG',
              navigatorKey: NavigationUtils.navigatorKey,
              onGenerateRoute: (settings) => MyRouter.generateRoute(settings),
              initialRoute: MyRouter.signIn,
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: ColorUtils.primaryColor,
                  iconTheme: IconThemeData(color: Colors.black),
                  foregroundColor: Colors.black,
                ),
                scaffoldBackgroundColor: Colors.white,
                textTheme: const TextTheme(
                  displayLarge: TextStyle(color: Colors.black),
                  displayMedium: TextStyle(color: Colors.black),
                  bodyMedium: TextStyle(color: Colors.black),
                  titleMedium: TextStyle(color: Colors.black),
                ),
                primaryColor: ColorUtils.primaryColor,
                splashColor: Colors.transparent,
                fontFamily: 'AvertaStd',
                timePickerTheme: const TimePickerThemeData(
                  backgroundColor: Colors.white,
                  dayPeriodTextColor: Colors.white,
                  dayPeriodColor: ColorUtils.primaryColor,
                  dialHandColor: ColorUtils.primaryColor,
                  dialTextColor: ColorUtils.primaryColor,
                ),
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: ColorUtils.primaryColor),
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
