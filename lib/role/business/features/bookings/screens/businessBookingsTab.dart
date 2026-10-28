import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class BusinessBookingsTab extends StatefulWidget {
  const BusinessBookingsTab({super.key});

  @override
  State<BusinessBookingsTab> createState() => _BusinessBookingsTabState();
}

class _BusinessBookingsTabState extends State<BusinessBookingsTab> {
  String _selectedFilter = 'All (8)';
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final List<String> _filters = const ['All (8)', 'Confirmed (5)', 'Pending (2)', 'Cancelled (1)'];

  final List<Map<String, dynamic>> _allBookings = const [
    {
      'id': 'Booking ID: #VN12843',
      'title': 'Himalayan Escape Lodge',
      'location': 'Kathmandu • 2 nights',
      'guest': 'Aarav Sharma',
      'date': 'Oct 26 - Oct 28, 2026',
      'status': 'Confirmed',
      'price': '\$240',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 'Booking ID: #VN12840',
      'title': 'Everest Base Camp Trek',
      'location': 'Solukhumbu • 12 days',
      'guest': 'Maya Gurung',
      'date': 'Nov 2 - Nov 14, 2026',
      'status': 'Pending',
      'price': '\$1,200',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 'Booking ID: #VN12837',
      'title': 'Pokhara Valley Resort',
      'location': 'Pokhara • 3 nights',
      'guest': 'Rohan Thapa',
      'date': 'Oct 30 - Nov 2, 2026',
      'status': 'Confirmed',
      'price': '\$360',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'id': 'Booking ID: #VN12832',
      'title': 'Chitwan Jungle Safari',
      'location': 'Chitwan • 2 nights',
      'guest': 'Sita Rai',
      'date': 'Oct 28 - Oct 30, 2026',
      'status': 'Confirmed',
      'price': '\$180',
      'image': 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=400&q=80',
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

    final filtered = _allBookings.where((b) {
      final status = (b['status'] as String).toLowerCase();
      bool matchesFilter = true;
      if (_selectedFilter.contains('Confirmed')) {
        matchesFilter = status.contains('confirmed');
      } else if (_selectedFilter.contains('Pending')) {
        matchesFilter = status.contains('pending');
      } else if (_selectedFilter.contains('Cancelled')) {
        matchesFilter = status.contains('cancel');
      }

      final query = _searchQuery.toLowerCase();
      final matchesQuery = query.isEmpty ||
          (b['title'] as String).toLowerCase().contains(query) ||
          (b['guest'] as String).toLowerCase().contains(query) ||
          (b['id'] as String).toLowerCase().contains(query);

      return matchesFilter && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Bookings',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Manage your reservations and requests.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
                  color: isDark ? Colors.white54 : const Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 12),

              // Filter Chips Row
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

              const SizedBox(height: 12),

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
                    hintText: 'Search by name, location or booking ID...',
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

              const SizedBox(height: 14),

              // Booking Cards
              ...filtered.map((b) {
                final bool isConfirmed = b['status'] == 'Confirmed';
                return Container(
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
                          b['image'],
                          width: 60,
                          height: 60,
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
                                    b['title'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 18,
                                  color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF2563EB)),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    b['location'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10.5,
                                      color: isDark ? Colors.white54 : const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                                Text(
                                  b['price'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.person_outline_rounded, size: 12, color: Color(0xFF64748B)),
                                const SizedBox(width: 3),
                                Text(
                                  b['guest'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white70 : const Color(0xFF334155),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isConfirmed
                                        ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                                        : const Color(0xFFFDB716).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    b['status'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: isConfirmed ? const Color(0xFF16A34A) : const Color(0xFFD97706),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  b['id'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                  ),
                                ),
                                Text(
                                  b['date'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                  ),
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
