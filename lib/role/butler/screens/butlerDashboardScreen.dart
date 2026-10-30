import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/home/screens/butlerHomeTab.dart';
import '../features/requests/screens/butlerRequestsTab.dart';
import '../features/guests/screens/butlerGuestsTab.dart';
import '../features/earnings/screens/butlerEarningsTab.dart';
import '../features/profile/screens/butlerProfileTab.dart';

class ButlerDashboardScreen extends StatefulWidget {
  const ButlerDashboardScreen({super.key});

  @override
  State<ButlerDashboardScreen> createState() => _ButlerDashboardScreenState();
}

class _ButlerDashboardScreenState extends State<ButlerDashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = const [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.room_service_outlined, 'activeIcon': Icons.room_service_rounded, 'label': 'Requests'},
    {'icon': Icons.king_bed_outlined, 'activeIcon': Icons.king_bed_rounded, 'label': 'Guests'},
    {'icon': Icons.payments_outlined, 'activeIcon': Icons.payments_rounded, 'label': 'Earnings'},
    {'icon': Icons.person_outline_rounded, 'activeIcon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = const Color(0xFF9333EA);
    final inactiveColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    final List<Widget> tabs = [
      ButlerHomeTab(
        onNavigateToRequests: () => setState(() => _selectedIndex = 1),
      ),
      const ButlerRequestsTab(),
      const ButlerGuestsTab(),
      const ButlerEarningsTab(),
      const ButlerProfileTab(),
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? activeColor.withValues(alpha: isDark ? 0.15 : 0.08)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutBack,
                          scale: isSelected ? 1.1 : 1.0,
                          child: Icon(
                            icon,
                            size: 17,
                            color: isSelected ? activeColor : inactiveColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          label,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
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
