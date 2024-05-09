import 'package:flutter/material.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/ui/screens/apply/apply_in_booking_page.dart';
import 'package:twg/ui/screens/apply/create_apply_page.dart';
import 'package:twg/ui/screens/apply/my_apply_page.dart';
import 'package:twg/ui/screens/booking/add_booking.dart';
import 'package:twg/ui/screens/booking/booking_screen.dart';
import 'package:twg/ui/screens/booking/confirm_location_screen.dart';
import 'package:twg/ui/screens/booking/my_booking_page.dart';
import 'package:twg/ui/screens/booking/pick_place_screen.dart';
import 'package:twg/ui/screens/booking/widget/booking_detail_screen.dart';
import 'package:twg/ui/screens/call/call.dart';
import 'package:twg/ui/screens/call/incoming_call.dart';
import 'package:twg/ui/screens/chat_room/chat_room_screen.dart';
import 'package:twg/ui/screens/chat_room/chat_screen.dart';
import 'package:twg/ui/screens/chatbot/chat_screen.dart';
import 'package:twg/ui/screens/home/home_screen.dart';
import 'package:twg/ui/screens/location/add_location_screen.dart';
import 'package:twg/ui/screens/location/choose_from_map.dart';
import 'package:twg/ui/screens/location/loading_screen.dart';
import 'package:twg/ui/screens/location/location_detail_screen.dart';
import 'package:twg/ui/screens/location/pick_location_screen.dart';
import 'package:twg/ui/screens/notification/notification_screen.dart';
import 'package:twg/ui/screens/onboarding/introduction_screen.dart';
import 'package:twg/ui/screens/profile_and_settings/account_screen.dart';
import 'package:twg/ui/screens/profile_and_settings/my_reviews/my_reviews_page.dart';
import 'package:twg/ui/screens/profile_and_settings/privacy_policy/privacy_policy_page.dart';
import 'package:twg/ui/screens/profile_and_settings/update_profile/update_profile_page.dart';
import 'package:twg/ui/screens/signin/signin.dart';
import 'package:twg/ui/screens/signup/signup.dart';
import 'package:twg/ui/screens/splash_screen/splash_screen.dart';

import '../ui/screens/navigation/navigation_screen.dart';
import '../ui/screens/profile_and_settings/driver_profile_screen.dart';

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
  static const String confirmPlaceMap = '/confirmPlaceMap';
  static const String notification = '/notification';
  static const String driverProfile = '/driverProfile';
  static const String navigation = '/navigation';
  static const String bookingDetail = '/bookingDetail';
  static const String chatbotScreen = '/chatbotScreen';
  static const String onBoarding = '/onBoarding';
  static const String addLocation = '/addLocation';
  static const String locationDetail = '/locationDetail';
  static const String pickLocation = '/pickLocation';
  static const String chooseFromMap = '/chooseFromMap';
  static const String loadingRecommend = '/loadingRecommend';
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
          BookingScreen(
            isRecommend: settings.arguments as bool,
          ),
        );
      case chatRoom:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ChatRoomScreen(),
        );
      case addBooking:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const AddBookingScreen(),
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
          const AccountScreen(),
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
      case confirmPlaceMap:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ConfirmPlaceScreen(),
        );
      case notification:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const NotificationScreen(),
        );
      case driverProfile:
        return _buildRouteNavigationWithoutEffect(
          settings,
          DriverProfileScreen(
            accountDto: settings.arguments as AccountDto,
          ),
        );
      case navigation:
        return _buildRouteNavigationWithoutEffect(
          settings,
          NavigationScreen(
            bookingDto: settings.arguments as BookingDto,
          ),
        );
      case bookingDetail:
        return _buildRouteNavigationWithoutEffect(
          settings,
          BookingDetailScreen(
            booking: settings.arguments as BookingDto,
          ),
        );
      case chatbotScreen:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const ChatBotScreen(),
        );
      case addLocation:
        return _buildRouteNavigationWithoutEffect(
          settings,
          AddLocationScreen(
            locationType: settings.arguments as SavePlaceType,
          ),
        );
      case locationDetail:
        return _buildRouteNavigationWithoutEffect(
          settings,
          LocationDetailScreen(
            location: settings.arguments as LocationDto,
          ),
        );
      case pickLocation:
        return _buildRouteNavigationWithoutEffect(
          settings,
          PickLocationScreen(
            locationDto: settings.arguments as LocationDto?,
          ),
        );
      case chooseFromMap:
        return _buildRouteNavigationWithoutEffect(
          settings,
          ChooseFromMapScreen(
            isLocation: settings.arguments as bool,
          ),
        );
      case loadingRecommend:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const LoadingPage(),
        );
      case onBoarding:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const OnBoardingScreen(),
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
