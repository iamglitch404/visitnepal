import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButlerNotificationsScreen extends StatefulWidget {
  const ButlerNotificationsScreen({super.key});

  @override
  State<ButlerNotificationsScreen> createState() => _ButlerNotificationsScreenState();
}

class _ButlerNotificationsScreenState extends State<ButlerNotificationsScreen> {
  final List<Map<String, dynamic>> _alerts = const [
    {
      'title': 'New VIP Tea & Coffee Order',
      'body': 'Aarav Sharma (Room 304) requested Hot Himalayan Butter Tea & coffee at 08:00 AM.',
      'time': '5m ago',
      'icon': Icons.coffee_rounded,
      'color': Color(0xFF9333EA),
    },
    {
      'title': 'VIP Guest Arrival Notification',
      'body': 'Maya Gurung checked into Tengboche Teahouse Suite #102. High altitude care requested.',
      'time': '1h ago',
      'icon': Icons.king_bed_rounded,
      'color': Color(0xFF2563EB),
    },
    {
      'title': 'Traveler Tip Credited',
      'body': '+\$350.00 USD gratuity tip credited to your payout balance.',
      'time': '1d ago',
      'icon': Icons.payments_rounded,
      'color': Color(0xFF16A34A),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Butler Service Notifications',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: _alerts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = _alerts[index];
            final Color color = item['color'] as Color;

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                    child: Icon(item['icon'] as IconData, color: color, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['title']!,
                                style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                              ),
                            ),
                            Text(item['time']!, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(item['body']!, style: GoogleFonts.plusJakartaSans(fontSize: 11, height: 1.35, color: isDark ? Colors.white70 : const Color(0xFF475569))),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
