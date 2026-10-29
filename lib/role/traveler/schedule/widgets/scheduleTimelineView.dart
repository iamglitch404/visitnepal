import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';

class ScheduleTimelineView extends StatelessWidget {
  final int selectedDay;
  final DateTime? selectedDate;

  const ScheduleTimelineView({
    super.key,
    required this.selectedDay,
    this.selectedDate,
  });

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  List<Map<String, dynamic>> _getEvents(DateTime date) {
    final monthShort = _months[date.month - 1];
    final datePattern = '$monthShort ${date.day}';

    for (final s in MockData.scheduleDays) {
      final sDate = s['date'] as String? ?? '';
      if (sDate.contains(datePattern)) {
        return List<Map<String, dynamic>>.from(s['events'] ?? []);
      }
    }

    if (date.month == 11) {
      if (date.day >= 12 && date.day <= 25) {
        return [
          {'time': '07:00 AM', 'title': 'Himalayan Trek Breakfast & Briefing', 'desc': 'Oxygen check & trail preparation with guide'},
          {'time': '08:30 AM', 'title': 'Morning Alpine Ascent', 'desc': 'Trail segment with panoramic mountain vistas'},
          {'time': '01:00 PM', 'title': 'Tea House Rest Stop', 'desc': 'Warm sherpa herbal tea & acclimatization pause'},
          {'time': '05:30 PM', 'title': 'Camp Arrival & Sunset View', 'desc': 'Golden hour photography over Himalayan peaks'},
        ];
      }
    }

    return [
      {'time': '08:00 AM', 'title': 'Morning City & Heritage Walk', 'desc': 'Explore local alleys, stupas, and artisan cafes'},
      {'time': '11:30 AM', 'title': 'Expedition Gear & Permit Check', 'desc': 'Review trek essentials with Himalayan Sherpa team'},
      {'time': '02:00 PM', 'title': 'Cultural Landmark Visit', 'desc': 'Boudhanath Stupa / Swayambhunath temple visit'},
      {'time': '06:30 PM', 'title': 'Traditional Nepali Dinner', 'desc': 'Authentic Thakali dal bhat & cultural music'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final date = selectedDate ?? DateTime.now();
    final events = _getEvents(date);
    final titleText = selectedDate != null
        ? 'Timeline Events for ${_months[date.month - 1]} ${date.day}'
        : 'Timeline Events for ${_months[date.month - 1]} ${date.day}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi_tethering_rounded, color: Color(0xFF16A34A), size: 12),
                  SizedBox(width: 4),
                  Text(
                    'GPS Live Sync',
                    style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final ev = events[i];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      ev['time'] ?? '',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ev['title'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ev['desc'] ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white54 : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF16A34A), size: 20),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
