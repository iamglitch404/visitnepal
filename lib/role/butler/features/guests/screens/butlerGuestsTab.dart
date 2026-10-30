import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButlerGuestsTab extends StatelessWidget {
  const ButlerGuestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> vipGuests = const [
      {
        'name': 'Aarav Sharma',
        'stay': 'Kathmandu Marriott • Suite #304',
        'diet': 'Gluten-Free, Himalayan Herbal Tea',
        'preferences': 'Heated blankets, Morning Coffee at 07:00 AM',
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
      },
      {
        'name': 'Maya Gurung',
        'stay': 'Tengboche Teahouse • Room #102',
        'diet': 'Vegetarian Dal Bhat, Yak Butter Tea',
        'preferences': 'Oxygen cylinder check before sleep, Hot shower',
        'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
      },
      {
        'name': 'Rohan Thapa',
        'stay': 'Namche Panorama Lodge • Room #210',
        'diet': 'High Protein, Fresh Fruit Juice',
        'preferences': 'Trek boots drying after 4 PM, Extra pillows',
        'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
      },
      {
        'name': 'Sita Rai',
        'stay': 'Lakeside Resort • Villa #4',
        'diet': 'Vegan, Green Tea & Ginger Honey',
        'preferences': 'Spa reservation assistance, Laundry service',
        'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'VIP Guest Roster & Preferences',
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF9333EA).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF9333EA).withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFF9333EA), size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('VIP Sherpa Butler Service Active', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 12.5)),
                          Text('4 VIP Travelers currently assigned under your personal hospitality care.', style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: const Color(0xFF64748B))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Assigned VIP Travelers',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 10),

              ...vipGuests.map((g) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(g['avatar'], width: 44, height: 44, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  g['name'],
                                  style: GoogleFonts.plusJakartaSans(fontSize: 13.5, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                                ),
                                Text(
                                  g['stay'],
                                  style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20, color: Color(0xFF0552A2)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/chat');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.restaurant_rounded, size: 12, color: Color(0xFF16A34A)),
                                const SizedBox(width: 4),
                                Text('Diet: ${g['diet']}', style: GoogleFonts.plusJakartaSans(fontSize: 10.5, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.info_outline_rounded, size: 12, color: Color(0xFF0552A2)),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text('Notes: ${g['preferences']}', style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: Colors.grey)),
                                ),
                              ],
                            ),
                          ],
                        ),
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
