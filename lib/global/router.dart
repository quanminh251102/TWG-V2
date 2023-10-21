import 'package:flutter/material.dart';
import 'package:twg/ui/screens/booking/add_booking.dart';
import 'package:twg/ui/screens/booking/booking_screen.dart';
import 'package:twg/ui/screens/home/home.dart';
import 'package:twg/ui/screens/signin/signin.dart';
import 'package:twg/ui/screens/signup/signup.dart';
import 'package:twg/ui/screens/splash_screen/splash_screen.dart';

class MyRouter {
  static const String splash = 'splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String booking = '/booking';
  static const String addBooking = '/addBooking';
  static PageRouteBuilder _buildRouteNavigationWithoutEffect(
      RouteSettings settings, Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      transitionDuration: Duration.zero,
      settings: settings,
    );
  }

  static PageRouteBuilder _buildRouteNavigation(
      RouteSettings settings, Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const SplashScreen(),
        );
      case signIn:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const SignInScreen(),
        );
      case signUp:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const SignUpScreen(),
        );
      case home:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const HomeScreen(),
        );
      case booking:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const BookingScreen(),
        );
      case addBooking:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const AddBookingScreen(),
        );
      default:
        return _buildRouteNavigationWithoutEffect(
          settings,
          Scaffold(
            body: Center(
              child: Text('No route found: ${settings.name}.'),
            ),
          ),
        );
    }
  }
}
