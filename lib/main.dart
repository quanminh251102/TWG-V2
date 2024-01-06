// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/theme_utils.dart';
import 'package:twg/ui/utils/navigation_utils.dart';
import 'package:twg/ui/utils/notification_utils.dart';
import 'core/utils/color_utils.dart';
import 'global/locator.dart';
import 'global/providers.dart';
import 'global/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  configLoading();
  await setupLocator();
  NotifiationUtils().initNotification();
  runApp(
    const MyApp(),
  );
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
  const MyApp({
    super.key,
  });
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );
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
            initialRoute: MyRouter.splash,
            locale: const Locale('vi', 'VN'), // Set the locale to Vietnamese
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale(
                'vi',
                'VN',
              ), // Include the Vietnamese locale
            ],
            darkTheme: ThemeUtils.darkTheme,
            theme: ThemeUtils.lightTheme,
            themeMode: ThemeMode.light,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
