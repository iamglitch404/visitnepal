import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class GuideExpeditionsTab extends StatefulWidget {
  const GuideExpeditionsTab({super.key});

  @override
  State<GuideExpeditionsTab> createState() => _GuideExpeditionsTabState();
}

class _GuideExpeditionsTabState extends State<GuideExpeditionsTab> {
  final List<Map<String, dynamic>> _stations = const [
    {'name': 'Lukla Airstrip', 'altitude': '2,860m', 'status': 'Completed', 'day': 'Day 1'},
    {'name': 'Phakding Lodge', 'altitude': '2,610m', 'status': 'Completed', 'day': 'Day 2'},
    {'name': 'Namche Bazaar', 'altitude': '3,440m', 'status': 'Completed', 'day': 'Day 3'},
    {'name': 'Tengboche Monastery', 'altitude': '3,867m', 'status': 'Current Location', 'day': 'Day 4'},
    {'name': 'Dingboche Valley', 'altitude': '4,410m', 'status': 'Next Station', 'day': 'Day 5'},
    {'name': 'Lobuche High Camp', 'altitude': '4,940m', 'status': 'Upcoming', 'day': 'Day 6'},
    {'name': 'Everest Base Camp', 'altitude': '5,364m', 'status': 'Goal', 'day': 'Day 7'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Live Route Tracker & GPS',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.sos_rounded, color: Color(0xFFEC1F27), size: 24),
            onPressed: () {
              AppFeedback.showInfo(context, 'Emergency SOS & Heli Air Ambulance Request Triggered');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Live Mountain Weather Advisory
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D9488).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF0D9488).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.ac_unit_rounded, color: Color(0xFF0D9488), size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tengboche Weather (3,867m): -2°C', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 12.5)),
                          const SizedBox(height: 2),
                          Text('High-altitude snow flurries expected at 4,000m. Trail clear.', style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: const Color(0xFF64748B))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Everest Base Camp Route Stations',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 10),

              // Route Station Timeline List
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: _stations.map((s) {
                    final bool isCurrent = s['status'] == 'Current Location';
                    final bool isDone = s['status'] == 'Completed';

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(
                              isCurrent
                                  ? Icons.my_location_rounded
                                  : (isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded),
                              color: isCurrent
                                  ? const Color(0xFF2563EB)
                                  : (isDone ? const Color(0xFF16A34A) : Colors.grey),
                              size: 18,
                            ),
                            if (_stations.indexOf(s) != _stations.length - 1)
                              Container(
                                width: 2,
                                height: 32,
                                color: isDone ? const Color(0xFF16A34A) : Colors.grey.withValues(alpha: 0.3),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    s['name'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w700,
                                      color: isCurrent
                                          ? const Color(0xFF2563EB)
                                          : (isDark ? Colors.white : const Color(0xFF0F172A)),
                                    ),
                                  ),
                                  Text(
                                    s['day'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white54 : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Altitude: ${s['altitude']} • Status: ${s['status']}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.5,
                                  color: isCurrent
                                      ? const Color(0xFF2563EB)
                                      : (isDark ? Colors.white54 : const Color(0xFF64748B)),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
