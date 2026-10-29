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
  late DateTime _selectedDate;
  late DateTime _currentMonth;
  final DateTime _today = DateTime.now();
  int _activeSubTab = 0;
  bool _isMonthGridView = false;
  final ScrollController _calendarScrollController = ScrollController();

  static const List<String> _weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = _today;
    _currentMonth = DateTime(_today.year, _today.month, 1);
  }

  @override
  void dispose() {
    _calendarScrollController.dispose();
    super.dispose();
  }

  List<DateTime> get _availableMonths {
    return List.generate(
      8,
      (i) => DateTime(_today.year, _today.month + i, 1),
    );
  }

  List<DateTime> get _daysInCurrentMonth {
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    return List.generate(
      daysInMonth,
      (index) => DateTime(_currentMonth.year, _currentMonth.month, index + 1),
    );
  }

  String get _monthYearTitle => '${_months[_currentMonth.month - 1]} ${_currentMonth.year}';

  void _onPrevDay() {
    setState(() {
      final prevDate = _selectedDate.subtract(const Duration(days: 1));
      _selectedDate = prevDate;
      if (prevDate.month != _currentMonth.month || prevDate.year != _currentMonth.year) {
        _currentMonth = DateTime(prevDate.year, prevDate.month, 1);
      }
    });
    _scrollToSelectedDate();
  }

  void _onNextDay() {
    setState(() {
      final nextDate = _selectedDate.add(const Duration(days: 1));
      _selectedDate = nextDate;
      if (nextDate.month != _currentMonth.month || nextDate.year != _currentMonth.year) {
        _currentMonth = DateTime(nextDate.year, nextDate.month, 1);
      }
    });
    _scrollToSelectedDate();
  }

  void _selectMonth(int month, int year) {
    setState(() {
      _currentMonth = DateTime(year, month, 1);
      final maxDays = DateTime(year, month + 1, 0).day;
      final targetDay = _selectedDate.day.clamp(1, maxDays);
      _selectedDate = DateTime(year, month, targetDay);
    });
    _scrollToSelectedDate();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2028, 12, 31),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _currentMonth = DateTime(picked.year, picked.month, 1);
      });
      _scrollToSelectedDate();
    }
  }

  void _scrollToSelectedDate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_calendarScrollController.hasClients) {
        final index = _selectedDate.day - 1;
        const itemWidth = 44.0;
        final screenWidth = MediaQuery.of(context).size.width;
        final targetOffset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
        final maxScroll = _calendarScrollController.position.maxScrollExtent;
        final clampedOffset = targetOffset.clamp(0.0, maxScroll);
        _calendarScrollController.animateTo(
          clampedOffset,
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  String _getHotelTitle(DateTime date) {
    if (date.month == 11) {
      if (date.day >= 12 && date.day <= 14) {
        return 'Yeti Mountain Lodge, Phakding';
      } else if (date.day >= 15 && date.day <= 22) {
        return 'Panorama Lodge & Sherpa Heritage, Namche';
      } else {
        return "The Dwarika's Hotel - Heritage Suite";
      }
    }
    return 'Kathmandu Marriott Hotel';
  }

  String _getHotelImage(DateTime date) {
    if (date.month == 11) {
      if (date.day >= 12) {
        return 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80';
      }
      return 'https://images.unsplash.com/photo-1518002171953-a080ee817e1f?auto=format&fit=crop&w=400&q=80';
    }
    return 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80';
  }

  Widget _buildMonthPill(int month, int year, String label, bool isDark) {
    final isCurrent = _currentMonth.month == month && _currentMonth.year == year;
    return GestureDetector(
      onTap: () => _selectMonth(month, year),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isCurrent
              ? const Color(0xFF2563EB)
              : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCurrent
                ? const Color(0xFF2563EB)
                : (isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
            color: isCurrent
                ? Colors.white
                : (isDark ? Colors.white70 : const Color(0xFF64748B)),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthGrid(bool isDark) {
    final firstWeekday = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday; // 1 = Mon, 7 = Sun
    final leadingPadding = firstWeekday - 1;
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final totalCells = leadingPadding + daysInMonth;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekdays.map((w) {
              return SizedBox(
                width: 32,
                child: Text(
                  w,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              if (index < leadingPadding) {
                return const SizedBox.shrink();
              }
              final dayNum = index - leadingPadding + 1;
              final cellDate = DateTime(_currentMonth.year, _currentMonth.month, dayNum);
              final isSelected = cellDate.year == _selectedDate.year &&
                  cellDate.month == _selectedDate.month &&
                  cellDate.day == _selectedDate.day;
              final isToday = cellDate.year == _today.year &&
                  cellDate.month == _today.month &&
                  cellDate.day == _today.day;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = cellDate;
                  });
                  _scrollToSelectedDate();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2563EB)
                        : (isToday
                            ? (isDark ? const Color(0xFF334155) : const Color(0xFFFEF3C7))
                            : Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : (isToday ? const Color(0xFFF59E0B) : (isDark ? Colors.white10 : const Color(0xFFF1F5F9))),
                      width: isToday || isSelected ? 1.4 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$dayNum',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: (isSelected || isToday) ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : (isToday
                                  ? const Color(0xFFD97706)
                                  : (isDark ? Colors.white : const Color(0xFF0F172A))),
                        ),
                      ),
                      if (cellDate.month == 11 && cellDate.day >= 12 && cellDate.day <= 25) ...[
                        const SizedBox(height: 2),
                        Container(
                          width: 3.5,
                          height: 3.5,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF16A34A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

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
              trailing: Switch(value: true, activeThumbColor: const Color(0xFF16A34A), onChanged: (_) {}),
            ),
            ListTile(
              leading: const Icon(Icons.air_rounded, color: Color(0xFF2563EB)),
              title: const Text('Acclimatization Check: 01:00 PM', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Check oxygen saturation & water hydration'),
              trailing: Switch(value: true, activeThumbColor: const Color(0xFF2563EB), onChanged: (_) {}),
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
              // Month Title & Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _monthYearTitle,
                            style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : const Color(0xFF1E3A8A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: isDark ? Colors.white70 : const Color(0xFF2563EB),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isMonthGridView ? Icons.view_week_rounded : Icons.calendar_month_rounded,
                          color: const Color(0xFF2563EB),
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        tooltip: _isMonthGridView ? 'Switch to Day Strip' : 'View Full Month Calendar',
                        onPressed: () => setState(() => _isMonthGridView = !_isMonthGridView),
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
                        onPressed: _onPrevDay,
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right_rounded, color: isDark ? Colors.white60 : const Color(0xFF94A3B8), size: 22),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 28, minHeight: 32),
                        onPressed: _onNextDay,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Dynamic Real Month Pills Selector
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    for (final m in _availableMonths) ...[
                      _buildMonthPill(m.month, m.year, '${_months[m.month - 1]} ${m.year}', isDark),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Real Calendar: Toggle between Full Month Grid and Horizontal Day Strip
              if (_isMonthGridView)
                _buildMonthGrid(isDark)
              else
                SizedBox(
                  height: 52,
                  child: ListView.separated(
                    controller: _calendarScrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _daysInCurrentMonth.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 6),
                    itemBuilder: (context, index) {
                      final date = _daysInCurrentMonth[index];
                      final int dayNum = date.day;
                      final String weekday = _weekdays[date.weekday - 1];
                      final bool isSelected = date.year == _selectedDate.year &&
                          date.month == _selectedDate.month &&
                          date.day == _selectedDate.day;
                      final bool isToday = date.year == _today.year &&
                          date.month == _today.month &&
                          date.day == _today.day;

                      if (isSelected) {
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDate = date),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 38,
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
                                  width: 3,
                                  height: 3,
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
                          onTap: () => setState(() => _selectedDate = date),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 38,
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
                                  width: 3,
                                  height: 3,
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
                        onTap: () => setState(() => _selectedDate = date),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 38,
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

              ScheduleHotelBanner(
                title: _getHotelTitle(_selectedDate),
                subtitle: 'Location to Explore Today',
                imageUrl: _getHotelImage(_selectedDate),
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
                ScheduleTimelineView(
                  selectedDay: _selectedDate.day,
                  selectedDate: _selectedDate,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
