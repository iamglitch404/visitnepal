import 'package:flutter/material.dart';
import '../../../../core/widgets/designSystem.dart';

class PlannerTab extends StatefulWidget {
  final VoidCallback? onBack;

  const PlannerTab({super.key, this.onBack});

  @override
  State<PlannerTab> createState() => _PlannerTabState();
}

class _PlannerStop {
  String destination;
  int days;
  String activity;

  _PlannerStop({required this.destination, this.days = 2, required this.activity});
}

class _PlannerTabState extends State<PlannerTab> {
  final List<_PlannerStop> _stops = [
    _PlannerStop(destination: 'Kathmandu Valley', days: 2, activity: 'UNESCO Temples & Heritage'),
    _PlannerStop(destination: 'Pokhara Lakeside', days: 3, activity: 'Phewa Lake & Paragliding'),
    _PlannerStop(destination: 'Annapurna Base Camp', days: 7, activity: 'High Altitude Trekking'),
  ];

  String _trekStyle = 'Teahouse Lodge';
  final Set<String> _selectedGear = {'Trekking Poles', 'Down Jacket', 'First Aid Kit'};

  final List<String> _gearOptions = [
    'Trekking Poles',
    'Down Jacket (-20°C)',
    'Sleeping Bag',
    'Crampons / Microspikes',
    'First Aid Kit',
    'Portable Oxygen O2',
    'UV Polarized Sunglasses',
    'Water Purification Kit',
  ];

  int get _totalDays => _stops.fold(0, (sum, item) => sum + item.days);
  int get _estimatedBudget {
    int rate = _trekStyle == 'Luxury Lodge' ? 140 : (_trekStyle == 'Camping Expedition' ? 110 : 85);
    return _totalDays * rate + (_selectedGear.length * 15);
  }

  void _addStop() {
    setState(() {
      _stops.add(_PlannerStop(destination: 'Chitwan National Park', days: 3, activity: 'Jungle Safari & Wildlife'));
    });
    AppFeedback.showInfo(context, 'Stop added to your custom itinerary');
  }

  void _removeStop(int index) {
    if (_stops.length > 1) {
      setState(() => _stops.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: const Text(
          'Plan Your Custom Trek',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: widget.onBack ?? () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2563EB),
                    const Color(0xFF1D4ED8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Total Duration',
                        style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_totalDays Days',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ],
                  ),
                  Container(width: 1, height: 42, color: Colors.white24),
                  Column(
                    children: [
                      const Text(
                        'Estimated Budget',
                        style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$$_estimatedBudget USD',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Trek Style & Accommodation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Row(
              children: ['Teahouse Lodge', 'Luxury Lodge', 'Camping Expedition'].map((style) {
                final isSelected = _trekStyle == style;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _trekStyle = style),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                            : (isDark ? const Color(0xFF1E293B) : Colors.white),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF16A34A) : (isDark ? Colors.white12 : const Color(0xFFE2E8F0)),
                          width: isSelected ? 1.6 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            style == 'Luxury Lodge'
                                ? Icons.hotel_rounded
                                : (style == 'Camping Expedition' ? Icons.terrain_rounded : Icons.home_work_rounded),
                            color: isSelected ? const Color(0xFF16A34A) : (isDark ? Colors.white60 : Colors.grey),
                            size: 20,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            style,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? const Color(0xFF16A34A) : (isDark ? Colors.white : const Color(0xFF0F172A)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tailor Daily Routes & Stops',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                TextButton.icon(
                  onPressed: _addStop,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add Stop'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ..._stops.asMap().entries.map((entry) {
              final idx = entry.key;
              final stop = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${idx + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2563EB),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stop.destination,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            stop.activity,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white54 : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline_rounded, size: 20),
                          onPressed: () {
                            if (stop.days > 1) setState(() => stop.days--);
                          },
                        ),
                        Text(
                          '${stop.days}d',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
                          onPressed: () => setState(() => stop.days++),
                        ),
                      ],
                    ),
                    if (_stops.length > 1)
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                        onPressed: () => _removeStop(idx),
                      ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),

            const Text(
              'Gear & Safety Equipment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'Select required gear for acclimatization and high passes:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _gearOptions.map((gear) {
                final isSelected = _selectedGear.contains(gear);
                return FilterChip(
                  label: Text(gear),
                  selected: isSelected,
                  selectedColor: const Color(0xFF16A34A).withValues(alpha: 0.18),
                  checkmarkColor: const Color(0xFF16A34A),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? const Color(0xFF16A34A) : (isDark ? Colors.white70 : const Color(0xFF334155)),
                  ),
                  onSelected: (val) {
                    setState(() {
                      if (val) {
                        _selectedGear.add(gear);
                      } else {
                        _selectedGear.remove(gear);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
              ),
              onPressed: () {
                AppFeedback.showSuccess(
                  context,
                  'Custom trek plan saved! $_totalDays days itinerary with ${_selectedGear.length} gear items compiled.',
                );
              },
              child: const Text(
                'Save & Generate Custom Expedition',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
