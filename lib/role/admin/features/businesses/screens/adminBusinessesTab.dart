import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../verification/screens/adminBusinessDetailsScreen.dart';

class AdminBusinessesTab extends StatefulWidget {
  const AdminBusinessesTab({super.key});

  @override
  State<AdminBusinessesTab> createState() => _AdminBusinessesTabState();
}

class _AdminBusinessesTabState extends State<AdminBusinessesTab> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _businesses = const [
    {
      'title': 'Himalayan Escape Lodge',
      'type': 'Hotel',
      'location': 'Kathmandu, Bagmati',
      'status': 'Verified',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Everest Base Camp Trek',
      'type': 'Trekking',
      'location': 'Solukhumbu, Koshi',
      'status': 'Verified',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Pokhara Valley Resort',
      'type': 'Hotel',
      'location': 'Pokhara, Gandaki',
      'status': 'Verified',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Chitwan Jungle Safari',
      'type': 'Activity',
      'location': 'Chitwan, Bagmati',
      'status': 'Verified',
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

    final filtered = _businesses.where((b) {
      final query = _searchQuery.toLowerCase();
      return query.isEmpty ||
          (b['title'] as String).toLowerCase().contains(query) ||
          (b['location'] as String).toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Registered Businesses',
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
                    hintText: 'Search verified businesses...',
                    hintStyle: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: isDark ? Colors.white38 : const Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Color(0xFF64748B)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              ...filtered.map((b) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdminBusinessDetailsScreen(business: b),
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
                            b['image'],
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                b['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                '${b['type']} • ${b['location']}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.5,
                                  color: isDark ? Colors.white54 : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 10),
                                        const SizedBox(width: 3),
                                        Text(
                                          b['status'],
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 9.5,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF16A34A),
                                          ),
                                        ),
                                      ],
                                    ),
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
