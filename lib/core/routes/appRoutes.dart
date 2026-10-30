import 'package:flutter/material.dart';

import '../../role/admin/features/profile/screens/adminNotificationsScreen.dart';
import '../../role/admin/features/profile/screens/adminSettingsScreen.dart';
import '../../role/admin/features/verification/screens/adminVerificationQueueScreen.dart';
import '../../role/admin/screens/adminDashboardScreen.dart';

import '../../role/auth/screens/loginScreen.dart';
import '../../role/auth/screens/splashScreen.dart';

import '../../role/business/features/listings/screens/editListingsScreen.dart';
import '../../role/business/features/notifications/screens/businessNotificationsScreen.dart';
import '../../role/business/features/profile/screens/editBusinessProfileScreen.dart';
import '../../role/business/screens/businessDashboardScreen.dart';

import '../../role/guide/features/profile/screens/editGuideProfileScreen.dart';
import '../../role/guide/features/profile/screens/guideNotificationsScreen.dart';
import '../../role/guide/screens/guideDashboardScreen.dart';

import '../../role/butler/features/profile/screens/editButlerProfileScreen.dart';
import '../../role/butler/features/profile/screens/butlerNotificationsScreen.dart';
import '../../role/butler/screens/butlerDashboardScreen.dart';

import '../../role/traveler/bookings/screens/bookingsTab.dart';
import '../../role/traveler/chat/screens/chatScreen.dart';
import '../../role/traveler/destinations/screens/destinationsTab.dart';
import '../../role/traveler/discover/screens/notificationsScreen.dart';
import '../../role/traveler/main/screens/mainScreen.dart';
import '../../role/traveler/profile/screens/editProfileScreen.dart';
import '../../role/traveler/profile/screens/profileAccount.dart';
import '../../role/traveler/profile/screens/settingsScreen.dart';

import '../../role/traveler/services/screens/activitiesScreen.dart';
import '../../role/traveler/services/screens/butlerScreen.dart';
import '../../role/traveler/services/screens/guidesScreen.dart';
import '../../role/traveler/services/screens/hotelsScreen.dart';
import '../../role/traveler/services/screens/permitsScreen.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String travelerMain = '/traveler_main';
  static const String destinations = '/destinations';
  static const String bookings = '/bookings';
  static const String profile = '/profile';
  static const String chat = '/chat';
  static const String notifications = '/notifications';
  static const String hotels = '/hotels';
  static const String guides = '/guides';
  static const String butler = '/butler';
  static const String activities = '/activities';
  static const String permits = '/permits';
  static const String editProfile = '/edit_profile';
  static const String settings = '/settings';

  static const String business = '/business';
  static const String editBusinessProfile = '/edit_business_profile';
  static const String editListings = '/edit_listings';
  static const String businessNotifications = '/business_notifications';

  static const String guide = '/guide';
  static const String editGuideProfile = '/edit_guide_profile';
  static const String guideNotifications = '/guide_notifications';

  static const String butlerPortal = '/butler_portal';
  static const String editButlerProfile = '/edit_butler_profile';
  static const String butlerNotifications = '/butler_notifications';

  static const String admin = '/admin';
  static const String adminQueue = '/admin_queue';
  static const String adminNotifications = '/admin_notifications';
  static const String adminSettings = '/admin_settings';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        login: (_) => const LoginScreen(),
        travelerMain: (_) => const MainScreen(),
        destinations: (_) => const DestinationsTab(),
        bookings: (_) => const BookingsTab(),
        profile: (_) => const ProfileAccountScreen(),
        chat: (_) => const ChatScreen(),
        notifications: (_) => const NotificationsScreen(),
        hotels: (_) => const HotelsScreen(),
        guides: (_) => const GuidesScreen(),
        butler: (_) => const ButlerScreen(),
        activities: (_) => const ActivitiesScreen(),
        permits: (_) => const PermitsScreen(),
        editProfile: (_) => const EditProfileScreen(),
        settings: (_) => const SettingsScreen(),
        business: (_) => const BusinessDashboardScreen(),
        editBusinessProfile: (_) => const EditBusinessProfileScreen(),
        editListings: (_) => const EditListingsScreen(),
        businessNotifications: (_) => const BusinessNotificationsScreen(),
        guide: (_) => const GuideDashboardScreen(),
        editGuideProfile: (_) => const EditGuideProfileScreen(),
        guideNotifications: (_) => const GuideNotificationsScreen(),
        butlerPortal: (_) => const ButlerDashboardScreen(),
        editButlerProfile: (_) => const EditButlerProfileScreen(),
        butlerNotifications: (_) => const ButlerNotificationsScreen(),
        admin: (_) => const AdminDashboardScreen(),
        adminQueue: (_) => const AdminVerificationQueueScreen(),
        adminNotifications: (_) => const AdminNotificationsScreen(),
        adminSettings: (_) => const AdminSettingsScreen(),
      };
}
