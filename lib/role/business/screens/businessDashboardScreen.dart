import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/home/screens/businessHomeTab.dart';
import '../features/bookings/screens/businessBookingsTab.dart';
import '../features/listings/screens/businessListingsTab.dart';
import '../features/analytics/screens/businessAnalyticsTab.dart';
import '../features/profile/screens/businessProfileTab.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({super.key});

  @override
  State<BusinessDashboardScreen> createState() => _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = const [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.calendar_month_outlined, 'activeIcon': Icons.calendar_month_rounded, 'label': 'Bookings'},
    {'icon': Icons.label_outlined, 'activeIcon': Icons.label_rounded, 'label': 'Listings'},
    {'icon': Icons.insights_rounded, 'activeIcon': Icons.insights_rounded, 'label': 'Analytics'},
    {'icon': Icons.person_outline_rounded, 'activeIcon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = const Color(0xFF16A34A);
    final inactiveColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    final List<Widget> tabs = [
      BusinessHomeTab(
        onNavigateToBookings: () => setState(() => _selectedIndex = 1),
      ),
      const BusinessBookingsTab(),
      const BusinessListingsTab(),
      const BusinessAnalyticsTab(),
      const BusinessProfileTab(),
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
