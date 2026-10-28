import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverServicesGrid extends StatelessWidget {
  final Function(String) onServiceSelected;

  const DiscoverServicesGrid({
    super.key,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exclusive Bookings',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              context,
              icon: FontAwesomeIcons.idCard,
              label: 'Permits',
              iconColor: const Color(0xFF0552A2),
              bgColor: const Color(0xFFEFF6FF),
              onTap: () => onServiceSelected('permits'),
            ),
            _buildItem(
              context,
              icon: FontAwesomeIcons.hotel,
              label: 'Hotels',
              iconColor: const Color(0xFF16A34A),
              bgColor: const Color(0xFFECFDF5),
              onTap: () => onServiceSelected('hotels'),
            ),
            _buildItem(
              context,
              icon: FontAwesomeIcons.bus,
              label: 'Transport',
              iconColor: const Color(0xFFFDB716),
              bgColor: const Color(0xFFFFFBEB),
              onTap: () => onServiceSelected('transport'),
            ),
            _buildItem(
              context,
              icon: FontAwesomeIcons.personWalkingWithCane,
              label: 'Guides',
              iconColor: const Color(0xFF0D9488),
              bgColor: const Color(0xFFE6FFFA),
              onTap: () => onServiceSelected('guides'),
            ),
            _buildItem(
              context,
              icon: FontAwesomeIcons.personSkiing,
              label: 'Activities',
              iconColor: const Color(0xFFEC1F27),
              bgColor: const Color(0xFFFEF2F2),
              onTap: () => onServiceSelected('activities'),
            ),
            _buildItem(
              context,
              icon: FontAwesomeIcons.conciergeBell,
              label: 'Butler',
              iconColor: const Color(0xFF9333EA),
              bgColor: const Color(0xFFF5F3FF),
              onTap: () => onServiceSelected('butler'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required dynamic icon,
    required String label,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isDark ? iconColor.withValues(alpha: 0.15) : bgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: icon is IconData
                  ? Icon(icon, color: iconColor, size: 17)
                  : FaIcon(icon, color: iconColor, size: 17),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}
