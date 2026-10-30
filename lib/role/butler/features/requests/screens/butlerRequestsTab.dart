import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class ButlerRequestsTab extends StatefulWidget {
  const ButlerRequestsTab({super.key});

  @override
  State<ButlerRequestsTab> createState() => _ButlerRequestsTabState();
}

class _ButlerRequestsTabState extends State<ButlerRequestsTab> {
  String _selectedFilter = 'All (6)';

  final List<String> _filters = const ['All (6)', 'In Progress (2)', 'Pending (3)', 'Completed (1)'];

  final List<Map<String, dynamic>> _requests = [
    {
      'title': 'Himalayan Butter Tea & Coffee',
      'guest': 'Aarav Sharma',
      'room': 'Kathmandu Marriott • Room 304',
      'time': '08:00 AM • Today',
      'status': 'In Progress',
      'notes': 'Extra yak butter, serve hot at 8 AM sharp.',
      'color': const Color(0xFF9333EA),
      'icon': Icons.coffee_rounded,
    },
    {
      'title': 'High-Altitude Oxygen Cylinder Check',
      'guest': 'Maya Gurung',
      'room': 'Tengboche Teahouse • Suite 102',
      'time': '09:30 AM • Today',
      'status': 'Pending',
      'notes': 'Check regulator pressure & pulse oximeter.',
      'color': const Color(0xFF0D9488),
      'icon': Icons.medical_services_rounded,
    },
    {
      'title': 'Trek Gear Drying & Laundry Dispatch',
      'guest': 'Rohan Thapa',
      'room': 'Namche Panorama Lodge • Room 210',
      'time': '11:00 AM • Today',
      'status': 'Pending',
      'notes': 'Dry gore-tex jacket & wool socks.',
      'color': const Color(0xFF2563EB),
      'icon': Icons.dry_cleaning_rounded,
    },
    {
      'title': 'Special Sherpa Cultural Meal Prep',
      'guest': 'Sita Rai',
      'room': 'Lakeside Resort • Villa #4',
      'time': '01:00 PM • Today',
      'status': 'Pending',
      'notes': 'Organic dal bhat with local ghee.',
      'color': const Color(0xFF16A34A),
      'icon': Icons.restaurant_menu_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filtered = _requests.where((r) {
      if (_selectedFilter == 'All (6)') return true;
      final status = (r['status'] as String).toLowerCase();
      if (_selectedFilter.contains('Progress')) return status.contains('progress');
      if (_selectedFilter.contains('Pending')) return status.contains('pending');
      return status.contains('completed');
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Hospitality Service Orders',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Chips
              SizedBox(
                height: 34,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final f = _filters[index];
                    final bool isSelected = f == _selectedFilter;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = f),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF9333EA) : (isDark ? const Color(0xFF1E293B) : Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isSelected ? const Color(0xFF9333EA) : (isDark ? Colors.white12 : const Color(0xFFE2E8F0))),
                        ),
                        child: Text(
                          f,
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

              const SizedBox(height: 14),

              // Request Item Cards
              ...filtered.map((item) {
                final Color color = item['color'] as Color;
                final bool isDone = item['status'] == 'Completed';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                            child: Icon(item['icon'] as IconData, color: color, size: 20),
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
                                        style: GoogleFonts.plusJakartaSans(fontSize: 13.5, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: color.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item['status'],
                                        style: GoogleFonts.plusJakartaSans(fontSize: 9.5, fontWeight: FontWeight.bold, color: color),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Guest: ${item['guest']} • ${item['room']}',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Notes: ${item['notes']}',
                        style: GoogleFonts.plusJakartaSans(fontSize: 11, fontStyle: FontStyle.italic, color: isDark ? Colors.white70 : const Color(0xFF475569)),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['time'],
                            style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDone ? Colors.grey : const Color(0xFF16A34A),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: Icon(isDone ? Icons.check_circle : Icons.task_alt, size: 12),
                            label: Text(
                              isDone ? 'Completed' : 'Mark Order Done',
                              style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                item['status'] = 'Completed';
                              });
                              AppFeedback.showSuccess(context, 'Service Order Marked Completed!');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
