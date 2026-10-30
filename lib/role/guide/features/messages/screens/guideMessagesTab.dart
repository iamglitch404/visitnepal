import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuideMessagesTab extends StatefulWidget {
  const GuideMessagesTab({super.key});

  @override
  State<GuideMessagesTab> createState() => _GuideMessagesTabState();
}

class _GuideMessagesTabState extends State<GuideMessagesTab> {
  String _selectedCategory = 'All';

  final List<String> _categories = const ['All', 'Hotels & Lodges', 'Group Travelers', 'Rescue & Agency'];

  final List<Map<String, dynamic>> _conversations = const [
    {
      'name': 'Tengboche Himalayan Lodge',
      'type': 'Hotels & Lodges',
      'lastMessage': 'Rooms reserved for 8 guests, hot soup ready at 5 PM.',
      'time': '5m ago',
      'unreadCount': 2,
      'avatar': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Aarav Sharma (Group Leader)',
      'type': 'Group Travelers',
      'lastMessage': 'We are passing Namche Bazaar, altitude feeling good!',
      'time': '20m ago',
      'unreadCount': 1,
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Himalayan Sherpa Expeditions Agency',
      'type': 'Rescue & Agency',
      'lastMessage': 'Helicopter standby confirmed for Lukla - EBC dispatch.',
      'time': '1h ago',
      'unreadCount': 0,
      'avatar': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'NTB High Altitude Rescue Center',
      'type': 'Rescue & Agency',
      'lastMessage': 'Weather clear for Tengboche - Dingboche trek segment.',
      'time': '3h ago',
      'unreadCount': 0,
      'avatar': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=200&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filtered = _conversations.where((c) {
      if (_selectedCategory == 'All') return true;
      return (c['type'] as String).toLowerCase() == _selectedCategory.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Trail Messages & Support',
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
                        color: isSelected ? const Color(0xFF0D9488) : (isDark ? const Color(0xFF1E293B) : Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isSelected ? const Color(0xFF0D9488) : (isDark ? Colors.white12 : const Color(0xFFE2E8F0))),
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
                  final int unread = item['unreadCount'] ?? 0;

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              item['avatar'],
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
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
                                        item['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      item['time'],
                                      style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['lastMessage'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: unread > 0 ? (isDark ? Colors.white : const Color(0xFF0F172A)) : Colors.grey,
                                          fontWeight: unread > 0 ? FontWeight.w700 : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (unread > 0) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF0D9488),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '$unread',
                                          style: GoogleFonts.plusJakartaSans(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
