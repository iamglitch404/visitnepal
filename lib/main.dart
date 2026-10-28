import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:visitnepal/core/theme/appTheme.dart';
import 'package:visitnepal/role/traveler/discover/screens/notificationsScreen.dart';
import 'package:visitnepal/role/traveler/chat/screens/chatScreen.dart';
import 'package:visitnepal/role/traveler/services/screens/hotelsScreen.dart';
import 'package:visitnepal/role/traveler/services/screens/guidesScreen.dart';
import 'package:visitnepal/role/traveler/services/screens/butlerScreen.dart';
import 'package:visitnepal/role/traveler/services/screens/activitiesScreen.dart';
import 'package:visitnepal/role/traveler/services/screens/permitsScreen.dart';
import 'package:visitnepal/role/business/screens/businessDashboardScreen.dart';
import 'package:visitnepal/role/admin/screens/adminDashboardScreen.dart';
import 'package:visitnepal/role/auth/screens/splashScreen.dart';
import 'package:visitnepal/role/auth/screens/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const VisitNepalApp());
}

class VisitNepalApp extends StatefulWidget {
  const VisitNepalApp({super.key});

  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);
  static final ValueNotifier<Color> accentColorNotifier = ValueNotifier(const Color(0xFF0552A2));

  @override
  State<VisitNepalApp> createState() => _VisitNepalAppState();
}

class _VisitNepalAppState extends State<VisitNepalApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: VisitNepalApp.themeModeNotifier,
      builder: (context, currentThemeMode, child) {
        return ValueListenableBuilder<Color>(
          valueListenable: VisitNepalApp.accentColorNotifier,
          builder: (context, currentAccentColor, child) {
            return MaterialApp(
              title: 'Visit Nepal',
              debugShowCheckedModeBanner: false,
              scrollBehavior: HideScrollbarBehavior(),
              theme: AppTheme.customLightTheme(currentAccentColor),
              darkTheme: AppTheme.customDarkTheme(currentAccentColor),
              themeMode: currentThemeMode,
              home: const SplashScreen(),
              routes: {
                '/splash': (_) => const SplashScreen(),
                '/login': (_) => const LoginScreen(),
                '/chat': (_) => const ChatScreen(),
                '/notifications': (_) => const NotificationsScreen(),
                '/hotels': (_) => const HotelsScreen(),
                '/guides': (_) => const GuidesScreen(),
                '/butler': (_) => const ButlerScreen(),
                '/activities': (_) => const ActivitiesScreen(),
                '/permits': (_) => const PermitsScreen(),
                '/business': (_) => const BusinessDashboardScreen(),
                '/admin': (_) => const AdminDashboardScreen(),
              },
            );
          },
        );
      },
    );
  }
}
