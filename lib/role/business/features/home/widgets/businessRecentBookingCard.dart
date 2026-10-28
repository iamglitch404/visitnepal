import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessRecentBookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final bool showDivider;

  const BusinessRecentBookingCard({
    super.key,
    required this.booking,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool isConfirmed = booking['status'] == 'Confirmed';

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          dense: true,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              booking['avatar'],
              width: 38,
              height: 38,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            booking['name'],
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          subtitle: Text(
            booking['location'],
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.5,
              color: isDark ? Colors.white54 : const Color(0xFF64748B),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: isConfirmed
                      ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                      : const Color(0xFFFDB716).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  booking['status'],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: isConfirmed ? const Color(0xFF16A34A) : const Color(0xFFD97706),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                booking['amount'],
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF1F5F9)),
      ],
    );
  }
}
