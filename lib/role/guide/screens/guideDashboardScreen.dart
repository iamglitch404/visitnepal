import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/home/screens/guideHomeTab.dart';
import '../features/expeditions/screens/guideExpeditionsTab.dart';
import '../features/hotels/screens/guideHotelsTab.dart';
import '../features/messages/screens/guideMessagesTab.dart';
import '../features/profile/screens/guideProfileTab.dart';

class GuideDashboardScreen extends StatefulWidget {
  const GuideDashboardScreen({super.key});

  @override
  State<GuideDashboardScreen> createState() => _GuideDashboardScreenState();
}

class _GuideDashboardScreenState extends State<GuideDashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navItems = const [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.terrain_outlined, 'activeIcon': Icons.terrain_rounded, 'label': 'Expeditions'},
    {'icon': Icons.hotel_outlined, 'activeIcon': Icons.hotel_rounded, 'label': 'Hotels'},
    {'icon': Icons.chat_bubble_outline_rounded, 'activeIcon': Icons.chat_bubble_rounded, 'label': 'Messages'},
    {'icon': Icons.person_outline_rounded, 'activeIcon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = const Color(0xFF0D9488);
    final inactiveColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    final List<Widget> tabs = [
      GuideHomeTab(
        onNavigateToExpeditions: () => setState(() => _selectedIndex = 1),
      ),
      const GuideExpeditionsTab(),
      const GuideHotelsTab(),
      const GuideMessagesTab(),
      const GuideProfileTab(),
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
