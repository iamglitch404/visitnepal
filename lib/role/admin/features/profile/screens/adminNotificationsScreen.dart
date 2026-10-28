import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  String _selectedCategory = 'All (8)';

  final List<String> _categories = const ['All (8)', 'Verification (5)', 'System (3)'];

  final List<Map<String, dynamic>> _notifications = const [
    {
      'title': 'New verification request',
      'body': 'Himalayan Escape Lodge has been submitted for verification.',
      'time': '2h ago',
      'type': 'Verification',
      'color': Color(0xFF0552A2),
      'icon': Icons.info_outline_rounded,
    },
    {
      'title': 'Business approved',
      'body': 'Everest Base Camp Trek has been verified successfully.',
      'time': '5h ago',
      'type': 'Verification',
      'color': Color(0xFF16A34A),
      'icon': Icons.check_circle_outline_rounded,
    },
    {
      'title': 'Document update required',
      'body': 'Pokhara Valley Resort needs a new PAN card for verification.',
      'time': '7h ago',
      'type': 'Verification',
      'color': Color(0xFFFDB716),
      'icon': Icons.warning_amber_rounded,
    },
    {
      'title': 'New registration',
      'body': 'Chitwan Jungle Safari has registered on the platform.',
      'time': '10h ago',
      'type': 'Verification',
      'color': Color(0xFF2563EB),
      'icon': Icons.business_rounded,
    },
    {
      'title': 'System maintenance',
      'body': 'Scheduled maintenance on Nov 1, 2026 (02:00 AM - 04:00 AM).',
      'time': '1d ago',
      'type': 'System',
      'color': Color(0xFF9333EA),
      'icon': Icons.settings_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filtered = _notifications.where((n) {
      if (_selectedCategory.contains('All')) return true;
      final type = (n['type'] as String).toLowerCase();
      if (_selectedCategory.contains('Verification')) return type == 'verification';
      return type == 'system';
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Category Filter Pills
            SizedBox(
              height: 34,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final bool isSelected = cat == _selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF16A34A)
                            : (isDark ? const Color(0xFF1E293B) : Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF16A34A)
                              : (isDark ? Colors.white12 : const Color(0xFFE2E8F0)),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF475569)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  final Color color = item['color'] as Color;

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: color,
                            size: 18,
                          ),
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
                                      item['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w800,
                                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    item['time'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item['body'],
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  height: 1.35,
                                  color: isDark ? Colors.white70 : const Color(0xFF475569),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
