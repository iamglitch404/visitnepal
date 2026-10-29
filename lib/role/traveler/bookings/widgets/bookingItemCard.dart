import 'package:flutter/material.dart';
import '../../../../core/widgets/designSystem.dart';

class BookingItemCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback onTap;

  const BookingItemCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color color = booking['color'] as Color? ?? theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: AppCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(booking['icon'] as IconData? ?? Icons.confirmation_number, color: color, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['id'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                            ),
                            Text(
                              booking['category'] ?? 'Expedition',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AppStatusChip(status: booking['status'] ?? 'Confirmed'),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              booking['title'] ?? '',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Provider: ${booking['provider']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  booking['amount'] ?? '',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                height: 1,
                thickness: 1,
                color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Left side: Booked Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 11,
                            color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Booked Date',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.1,
                              color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        booking['date'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Right side: Booked By
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 12,
                          color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Booked By',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.1,
                            color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      booking['bookedBy'] ?? 'Aayush Pradhan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
