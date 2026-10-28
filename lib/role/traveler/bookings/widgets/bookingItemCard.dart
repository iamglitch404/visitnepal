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
                              booking['date'] ?? '',
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
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.qr_code, size: 16, color: Color(0xFF16A34A)),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Tap to view Boarding Pass & QR Voucher',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF16A34A)),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right_rounded, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
