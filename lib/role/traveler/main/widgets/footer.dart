import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int selectedIndex;
  final List<Map<String, dynamic>> navItems;
  final Function(int) onDestinationSelected;

  const Footer({
    super.key,
    required this.selectedIndex,
    required this.navItems,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return SafeArea(
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
              color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navItems.map((item) {
            final int index = navItems.indexOf(item);
            final bool isSelected = index == selectedIndex;
            final String label = item['label'];
            final IconData icon = isSelected ? (item['activeIcon'] ?? item['icon']) : item['icon'];

            return Expanded(
              child: GestureDetector(
                onTap: () => onDestinationSelected(index),
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
                      // Animated Icon
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

                      // Animated Label
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeInOut,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                          color: isSelected ? activeColor : inactiveColor,
                          letterSpacing: -0.2,
                        ),
                        child: Text(label),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
