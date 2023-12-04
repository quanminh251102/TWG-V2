import 'package:flutter/material.dart';
import 'package:twg/ui/screens/apply/apply_in_booking_page.dart';
import 'package:twg/ui/screens/apply/create_apply_page.dart';
import 'package:twg/ui/screens/apply/my_apply_page.dart';
import 'package:twg/ui/screens/apply/apply_in_booking_page.dart';
import 'package:twg/ui/screens/apply/create_apply_page.dart';
import 'package:twg/ui/screens/apply/my_apply_page.dart';
import 'package:twg/ui/screens/booking/add_booking.dart';
import 'package:twg/ui/screens/booking/booking_screen.dart';
import 'package:twg/ui/screens/booking/my_booking_page.dart';
import 'package:twg/ui/screens/booking/pick_place_screen.dart';
import 'package:twg/ui/screens/call/call.dart';
import 'package:twg/ui/screens/call/incoming_call.dart';
import 'package:twg/ui/screens/chat_room/chat_room_screen.dart';
import 'package:twg/ui/screens/chat_room/chat_screen.dart';
import 'package:twg/ui/screens/home/home_screen.dart';
import 'package:twg/ui/screens/profile_and_settings/my_reviews/my_reviews_page.dart';
import 'package:twg/ui/screens/profile_and_settings/privacy_policy/privacy_policy_page.dart';
import 'package:twg/ui/screens/profile_and_settings/profile_screen.dart';
import 'package:twg/ui/screens/profile_and_settings/update_profile/update_profile_page.dart';
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
  static const String chatRoom = '/chatRoom';
  static const String message = '/message';
  static const String call = '/call';
  static const String incomingCall = '/incomingCall';
  static const String profile = '/profile';
  static const String updateProfile = '/updateProfile';
  static const String privacyPolicy = '/privacyPolicy';
  static const String createApply = '/createApply';
  static const String applyInBooking = '/applyInBooking';
  static const String myApply = '/myApply';
  static const String myBooking = '/myBooking';
  static const String myReview = '/myReview';
  static const String pickPlaceMap = '/pickPlaceMap';
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
      case chatRoom:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ChatRoomScreen(),
        );
      case addBooking:
        return _buildRouteNavigationWithoutEffect(
          settings,
          AddBookingScreen(
            bookingType: settings.arguments as BookingType,
          ),
        );
      case message:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ChatScreen(),
        );
      case call:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const CallScreen(),
        );
      case incomingCall:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const InComingCallScreen(),
        );
      case profile:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ProfileScreen(),
        );
      case privacyPolicy:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const PrivacyPolicyPage(),
        );
      case updateProfile:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const UpdateProfilePage(),
        );

      case createApply:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const CreateApplyPage(),
        );
      case applyInBooking:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ApplyInBookingPage(),
        );
      case myApply:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const MyApplyPage(),
        );
      case myBooking:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const MyBookPage(),
        );

      case myReview:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const MyReViewsPage(),
        );
      case pickPlaceMap:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const PickPlaceScreen(),
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
