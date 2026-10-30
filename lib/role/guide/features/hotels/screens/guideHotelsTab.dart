import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class GuideHotelsTab extends StatefulWidget {
  const GuideHotelsTab({super.key});

  @override
  State<GuideHotelsTab> createState() => _GuideHotelsTabState();
}

class _GuideHotelsTabState extends State<GuideHotelsTab> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All (6)';

  final List<String> _filters = const ['All (6)', 'Everest Teahouses (3)', 'Pokhara Lodges (2)', 'Luxury Resorts (1)'];

  final List<Map<String, dynamic>> _hotels = const [
    {
      'name': 'Tengboche Himalayan Lodge',
      'location': 'Tengboche, Solukhumbu (3,867m)',
      'type': 'Teahouse',
      'price': '\$25 / night',
      'rating': 4.8,
      'facilities': ['Hot Shower', 'Wifi', 'Heated Dining'],
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
    {
      'name': 'Namche Sherpa Panorama Lodge',
      'location': 'Namche Bazaar (3,440m)',
      'type': 'Teahouse',
      'price': '\$35 / night',
      'rating': 4.9,
      'facilities': ['Attached Bath', 'Wifi', 'Bakery'],
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'name': 'Himalayan Escape Lodge',
      'location': 'Kathmandu, Bagmati',
      'type': 'Luxury Resort',
      'price': '\$150 / night',
      'rating': 4.95,
      'facilities': ['Spa', 'Restaurant', 'Airport Pickup'],
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
    {
      'name': 'Pokhara Valley Lakeside Resort',
      'location': 'Lakeside, Pokhara',
      'type': 'Pokhara Lodge',
      'price': '\$80 / night',
      'rating': 4.85,
      'facilities': ['Lake View', 'Swimming Pool', 'Wifi'],
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'name': 'Dingboche High Peak Lodge',
      'location': 'Dingboche Valley (4,410m)',
      'type': 'Teahouse',
      'price': '\$30 / night',
      'rating': 4.7,
      'facilities': ['Oxygen Cylinder', 'Solar Heated Water'],
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
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

    final filtered = _hotels.where((h) {
      final type = (h['type'] as String).toLowerCase();
      bool matchesFilter = true;
      if (_selectedFilter.contains('Everest')) {
        matchesFilter = type == 'teahouse';
      } else if (_selectedFilter.contains('Pokhara')) {
        matchesFilter = type.contains('pokhara');
      } else if (_selectedFilter.contains('Luxury')) {
        matchesFilter = type.contains('luxury');
      }

      final query = _searchQuery.toLowerCase();
      final matchesQuery = query.isEmpty ||
          (h['name'] as String).toLowerCase().contains(query) ||
          (h['location'] as String).toLowerCase().contains(query);

      return matchesFilter && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Hotels & Teahouse Finder',
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
                  border: Border.all(color: isDark ? Colors.white12 : const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (val) => setState(() => _searchQuery = val.trim()),
                  style: GoogleFonts.plusJakartaSans(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Search teahouses, lodges & resorts for travelers...',
                    hintStyle: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: isDark ? Colors.white38 : const Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Color(0xFF64748B)),
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
                          color: isSelected ? const Color(0xFF0D9488) : (isDark ? const Color(0xFF1E293B) : Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isSelected ? const Color(0xFF0D9488) : (isDark ? Colors.white12 : const Color(0xFFE2E8F0))),
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

              // Hotel List Cards
              ...filtered.map((h) {
                final List<String> facilities = List<String>.from(h['facilities'] ?? []);
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
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              h['image'],
                              width: 68,
                              height: 68,
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
                                        h['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w800,
                                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star_rounded, color: Color(0xFFFDB716), size: 14),
                                        const SizedBox(width: 2),
                                        Text('${h['rating']}', style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF2563EB)),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        h['location'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  h['price'],
                                  style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w900, color: const Color(0xFF0D9488)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: facilities.map((f) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(f, style: GoogleFonts.plusJakartaSans(fontSize: 9.5, fontWeight: FontWeight.w600)),
                              )).toList(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D9488),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              AppFeedback.showSuccess(context, 'Group booking reservation request sent to ${h['name']}');
                            },
                            child: Text('Reserve for Group', style: GoogleFonts.plusJakartaSans(fontSize: 10.5, fontWeight: FontWeight.bold)),
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
