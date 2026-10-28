import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adminBusinessDetailsScreen.dart';

class AdminVerificationQueueScreen extends StatefulWidget {
  const AdminVerificationQueueScreen({super.key});

  @override
  State<AdminVerificationQueueScreen> createState() => _AdminVerificationQueueScreenState();
}

class _AdminVerificationQueueScreenState extends State<AdminVerificationQueueScreen> {
  String _selectedFilter = 'All (421)';
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final List<String> _filters = const ['All (421)', 'Hotels (162)', 'Activities (98)', 'Trekking (72)'];

  final List<Map<String, dynamic>> _queueItems = const [
    {
      'title': 'Himalayan Escape Lodge',
      'type': 'Hotel',
      'location': 'Kathmandu',
      'time': '2h ago',
      'status': 'Pending',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Everest Base Camp Trek',
      'type': 'Trekking',
      'location': 'Solukhumbu',
      'time': '4h ago',
      'status': 'Pending',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Pokhara Valley Resort',
      'type': 'Hotel',
      'location': 'Pokhara',
      'time': '6h ago',
      'status': 'Pending',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Chitwan Jungle Safari',
      'type': 'Activity',
      'location': 'Chitwan',
      'time': '8h ago',
      'status': 'Pending',
      'image': 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Annapurna View Lodge',
      'type': 'Hotel',
      'location': 'Pokhara',
      'time': '10h ago',
      'status': 'Pending',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filtered = _queueItems.where((item) {
      final type = (item['type'] as String).toLowerCase();
      bool matchesFilter = true;
      if (_selectedFilter.contains('Hotels')) {
        matchesFilter = type == 'hotel';
      } else if (_selectedFilter.contains('Activities')) {
        matchesFilter = type == 'activity';
      } else if (_selectedFilter.contains('Trekking')) {
        matchesFilter = type == 'trekking';
      }

      final query = _searchQuery.toLowerCase();
      final matchesQuery = query.isEmpty ||
          (item['title'] as String).toLowerCase().contains(query) ||
          (item['location'] as String).toLowerCase().contains(query);

      return matchesFilter && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Verification Queue',
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
              // Search Bar
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (val) => setState(() => _searchQuery = val.trim()),
                  style: GoogleFonts.plusJakartaSans(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Search by name, location or business ID...',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                    ),
                    prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Color(0xFF64748B)),
                    suffixIcon: const Icon(Icons.tune_rounded, size: 18, color: Color(0xFF64748B)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),

              const SizedBox(height: 12),

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

              // Queue List Items
              ...filtered.map((item) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdminBusinessDetailsScreen(business: item),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item['image'],
                            width: 58,
                            height: 58,
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
                                      item['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w800,
                                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEF3C7),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Pending',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFFD97706),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${item['type']} • ${item['location']}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: isDark ? Colors.white54 : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['time'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 16,
                                    color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
