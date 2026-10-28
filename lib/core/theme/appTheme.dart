import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Brand New Color Palette
  static const Color skyGlacierBlue = Color(0xFF92C4EA);      // Hex 1
  static const Color royalNepalBlue = Color(0xFF0552A2);      // Hex 2 (Primary)
  static const Color crimsonNepalRed = Color(0xFFEC1F27);     // Hex 3 (Secondary)
  static const Color goldenHimalayanYellow = Color(0xFFFDB716); // Hex 4 (Gold Accent)

  static const Color brandBlue = royalNepalBlue;
  static const Color accentRed = crimsonNepalRed;
  static const Color primaryGreen = royalNepalBlue;
  static const Color bgWarm = Colors.white;
  static const Color cardWhite = Colors.white;
  static const Color darkText = Color(0xFF0F172A);

  static ThemeData customLightTheme(Color primaryColor) {
    final baseTheme = ThemeData(brightness: Brightness.light);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: crimsonNepalRed,
        tertiary: goldenHimalayanYellow,
        surface: cardWhite,
        onSurface: darkText,
      ),
      scaffoldBackgroundColor: bgWarm,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTheme.textTheme),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.06), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgWarm,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: darkText),
        foregroundColor: darkText,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: cardWhite,
        elevation: 16,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardWhite,
        indicatorColor: primaryColor.withValues(alpha: 0.08),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: primaryColor);
          }
          return const IconThemeData(color: Color(0xFF64748B));
        }),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
      ),
    );
  }

  static ThemeData customDarkTheme(Color primaryColor) {
    const Color bgDark = Color(0xFF090D16);
    const Color cardDark = Color(0xFF161F30);
    const Color lightText = Color(0xFFF8FAFC);
    final baseTheme = ThemeData(brightness: Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: crimsonNepalRed,
        tertiary: goldenHimalayanYellow,
        surface: cardDark,
        onSurface: lightText,
      ),
      scaffoldBackgroundColor: bgDark,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTheme.textTheme),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.06), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgDark,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: lightText),
        foregroundColor: lightText,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: cardDark,
        elevation: 16,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardDark,
        indicatorColor: primaryColor.withValues(alpha: 0.12),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: primaryColor);
          }
          return const IconThemeData(color: Color(0xFF94A3B8));
        }),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: lightText,
          ),
        ),
      ),
    );
  }
}

class HideScrollbarBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
