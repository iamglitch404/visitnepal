import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/home/screens/adminHomeTab.dart';
import '../features/verification/screens/adminVerificationQueueScreen.dart';
import '../features/businesses/screens/adminBusinessesTab.dart';
import '../features/analytics/screens/adminAnalyticsTab.dart';
import '../features/profile/screens/adminProfileTab.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = const [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.verified_user_outlined, 'activeIcon': Icons.verified_user_rounded, 'label': 'Verification'},
    {'icon': Icons.storefront_outlined, 'activeIcon': Icons.storefront_rounded, 'label': 'Businesses'},
    {'icon': Icons.insights_rounded, 'activeIcon': Icons.insights_rounded, 'label': 'Reports'},
    {'icon': Icons.person_outline_rounded, 'activeIcon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = const Color(0xFF16A34A);
    final inactiveColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    final List<Widget> tabs = [
      AdminHomeTab(
        onNavigateToQueue: () => setState(() => _selectedIndex = 1),
      ),
      const AdminVerificationQueueScreen(),
      const AdminBusinessesTab(),
      const AdminAnalyticsTab(),
      const AdminProfileTab(),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: tabs,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navItems.map((item) {
              final int index = _navItems.indexOf(item);
              final bool isSelected = index == _selectedIndex;
              final String label = item['label'];
              final IconData icon = isSelected ? (item['activeIcon'] ?? item['icon']) : item['icon'];

              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutBack,
                          scale: isSelected ? 1.05 : 1.0,
                          child: Icon(
                            icon,
                            size: 20,
                            color: isSelected ? activeColor : inactiveColor,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          label,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.5,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? activeColor : inactiveColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
