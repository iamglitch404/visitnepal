import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';
import '../../destinations/screens/packageDetailScreen.dart';
import '../widgets/scheduleLocationCard.dart';
import '../widgets/scheduleActivityCard.dart';
import '../widgets/scheduleTimelineView.dart';
import '../widgets/scheduleHotelBanner.dart';

class GuideTab extends StatefulWidget {
  const GuideTab({super.key});

  @override
  State<GuideTab> createState() => _GuideTabState();
}

class _GuideTabState extends State<GuideTab> {
  int _selectedDay = 25;
  final int _todayDay = 26;
  int _activeSubTab = 0;

  final List<Map<String, dynamic>> _calendarDays = [
    {'weekday': 'Sa', 'day': 24},
    {'weekday': 'Su', 'day': 25},
    {'weekday': 'Mo', 'day': 26},
    {'weekday': 'Tu', 'day': 27},
    {'weekday': 'We', 'day': 28},
    {'weekday': 'Th', 'day': 29},
    {'weekday': 'Fr', 'day': 30},
    {'weekday': 'Sa', 'day': 31},
  ];

  void _showAddCompanionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF2563EB)),
            SizedBox(width: 8),
            Text('Invite Trek Companion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: const Text(
          'Share your live itinerary and schedule with companions, guides, or family members for live GPS sync.',
          style: TextStyle(fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              AppFeedback.showSuccess(context, 'Invite link copied to clipboard!');
            },
            child: const Text('Copy Invite Link'),
          ),
        ],
      ),
    );
  }

  void _showAlarmBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.alarm_add_rounded, color: Color(0xFF16A34A), size: 24),
                SizedBox(width: 8),
                Text('Trek Altitude Alarm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Set wake-up alarm and altitude acclimatization reminders for your daily trek itinerary.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.access_time_filled_rounded, color: Color(0xFF16A34A)),
              title: const Text('Departure Alarm: 06:00 AM', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Triggered 30 mins before Lukla / trail departure'),
              trailing: Switch(value: true, activeColor: const Color(0xFF16A34A), onChanged: (_) {}),
            ),
            ListTile(
              leading: const Icon(Icons.air_rounded, color: Color(0xFF2563EB)),
              title: const Text('Acclimatization Check: 01:00 PM', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Check oxygen saturation & water hydration'),
              trailing: Switch(value: true, activeColor: const Color(0xFF2563EB), onChanged: (_) {}),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'October 2026',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF1E3A8A),
                      letterSpacing: -0.2,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.calendar_month_outlined, color: Color(0xFF2563EB), size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        onPressed: () {
                          AppFeedback.showInfo(context, 'Calendar view selected');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_add_alt_1_outlined, color: Color(0xFF2563EB), size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        onPressed: _showAddCompanionDialog,
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_left_rounded, color: isDark ? Colors.white60 : const Color(0xFF94A3B8), size: 22),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 28, minHeight: 32),
                        onPressed: () {
                          setState(() {
                            if (_selectedDay > 24) _selectedDay--;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right_rounded, color: isDark ? Colors.white60 : const Color(0xFF94A3B8), size: 22),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 28, minHeight: 32),
                        onPressed: () {
                          setState(() {
                            if (_selectedDay < 31) _selectedDay++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _calendarDays.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6),
                  itemBuilder: (context, index) {
                    final item = _calendarDays[index];
                    final int dayNum = item['day'];
                    final String weekday = item['weekday'];
                    final bool isSelected = dayNum == _selectedDay;
                    final bool isToday = dayNum == _todayDay;

                    if (isSelected) {
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDay = dayNum),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 36,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                weekday,
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$dayNum',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Container(
                                width: 2.5,
                                height: 2.5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (isToday) {
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDay = dayNum),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 36,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFF59E0B),
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                weekday,
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFD97706),
                                ),
                              ),
                              Text(
                                '$dayNum',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFD97706),
                                ),
                              ),
                              const SizedBox(height: 1),
                              Container(
                                width: 2.5,
                                height: 2.5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF59E0B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDay = dayNum),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 36,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E293B) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weekday,
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w400,
                                color: isDark ? Colors.white54 : const Color(0xFF64748B),
                              ),
                            ),
                            Text(
                              '$dayNum',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              const ScheduleHotelBanner(
                title: 'Kathmandu Marriott Hotel',
                subtitle: 'Location to Explore Today',
                imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
              ),

              const SizedBox(height: 16),

              // Sub-Tab Switcher Row (Itinerary / Schedules)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _activeSubTab = 0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                decoration: BoxDecoration(
                                  color: _activeSubTab == 0
                                      ? const Color(0xFF16A34A)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.map_rounded,
                                      size: 16,
                                      color: _activeSubTab == 0
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : const Color(0xFF64748B)),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Itinerary',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: _activeSubTab == 0
                                            ? Colors.white
                                            : (isDark ? Colors.white70 : const Color(0xFF64748B)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _activeSubTab = 1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                decoration: BoxDecoration(
                                  color: _activeSubTab == 1
                                      ? const Color(0xFF16A34A)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_time_filled_rounded,
                                      size: 16,
                                      color: _activeSubTab == 1
                                          ? Colors.white
                                          : (isDark ? Colors.white60 : const Color(0xFF64748B)),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Schedules',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: _activeSubTab == 1
                                            ? Colors.white
                                            : (isDark ? Colors.white70 : const Color(0xFF64748B)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Alarm / Add Action Button
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF16A34A), size: 26),
                    onPressed: _showAlarmBottomSheet,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              if (_activeSubTab == 0) ...[
                Text(
                  'Locations to Explore Today',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: ScheduleLocationCard(
                        title: 'Everest Base Camp Trek',
                        location: 'Solukhumbu, Nepal',
                        imageUrl: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
                        rating: '4.95',
                        onTap: () {
                          final dest = MockData.destinations.firstWhere(
                            (d) => d['title'].toString().contains('Everest'),
                            orElse: () => MockData.destinations[0],
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PackageDetailScreen(package: dest)));
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ScheduleLocationCard(
                        title: 'Chitwan National Park Safari',
                        location: 'Chitwan, Nepal',
                        imageUrl: 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
                        rating: '4.88',
                        onTap: () {
                          final dest = MockData.destinations.firstWhere(
                            (d) => d['title'].toString().contains('Chitwan'),
                            orElse: () => MockData.destinations[0],
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PackageDetailScreen(package: dest)));
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  'RECOMMENDED ACTIVITIES',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: isDark ? Colors.white54 : const Color(0xFF8898AA),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 185,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      ScheduleActivityCard(
                        title: 'Sarangkot Paraglid...',
                        description: 'Soar like a hawk over Phewa Lake with specta...',
                        imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80',
                      ),
                      SizedBox(width: 12),
                      ScheduleActivityCard(
                        title: 'Trisuli River White ...',
                        description: 'Exciting class III/IV rapids along the scenic Trisuli R...',
                        imageUrl: 'https://images.unsplash.com/photo-1510312305653-8ed496efae75?auto=format&fit=crop&w=600&q=80',
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 32),
              ] else ...[
                ScheduleTimelineView(selectedDay: _selectedDay),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
