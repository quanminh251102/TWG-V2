import 'package:flutter/material.dart';
import 'package:twg/ui/screens/signin/signin.dart';
import 'package:twg/ui/screens/signup/signup.dart';

class MyRouter {
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String home = '/home';
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
      case signUp:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const SignUpScreen(),
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
