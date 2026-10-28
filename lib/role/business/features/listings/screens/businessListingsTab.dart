import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class BusinessListingsTab extends StatefulWidget {
  const BusinessListingsTab({super.key});

  @override
  State<BusinessListingsTab> createState() => _BusinessListingsTabState();
}

class _BusinessListingsTabState extends State<BusinessListingsTab> {
  String _selectedCategory = 'All (4)';
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final List<String> _categories = const ['All (4)', 'Hotels (2)', 'Activities (1)', 'Trekking (1)'];

  final List<Map<String, dynamic>> _myListings = [
    {
      'title': 'Himalayan Escape Lodge',
      'category': 'Hotel',
      'location': 'Kathmandu',
      'price': '\$150 / night',
      'status': 'Active',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Everest Base Camp Trek',
      'category': 'Trekking',
      'location': 'Solukhumbu',
      'price': '\$1,200 / person',
      'status': 'Active',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Pokhara Valley Resort',
      'category': 'Hotel',
      'location': 'Pokhara',
      'price': '\$120 / night',
      'status': 'Active',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Chitwan Jungle Safari',
      'category': 'Activity',
      'location': 'Chitwan',
      'price': '\$80 / person',
      'status': 'Active',
      'image': 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=400&q=80',
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showAddListingSheet() {
    final titleCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    String categoryVal = 'Hotel';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
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
                    const SizedBox(height: 14),
                    Text(
                      'Add New Business Listing',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),

                    TextField(
                      controller: titleCtrl,
                      decoration: const InputDecoration(labelText: 'Listing Title', hintText: 'Annapurna Eco Lodge'),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: categoryVal,
                            decoration: const InputDecoration(labelText: 'Category'),
                            items: ['Hotel', 'Trekking', 'Activity']
                                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                                .toList(),
                            onChanged: (v) => setSheetState(() => categoryVal = v!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: priceCtrl,
                            decoration: const InputDecoration(labelText: 'Price / Rate', hintText: '\$150 / night'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: locationCtrl,
                      decoration: const InputDecoration(labelText: 'Location / Region', hintText: 'Pokhara, Nepal'),
                    ),

                    const SizedBox(height: 20),

                    AppButton(
                      text: 'Publish Listing',
                      width: double.infinity,
                      onPressed: () {
                        if (titleCtrl.text.trim().isEmpty) return;
                        setState(() {
                          _myListings.add({
                            'title': titleCtrl.text.trim(),
                            'category': categoryVal,
                            'location': locationCtrl.text.trim().isEmpty ? 'Nepal' : locationCtrl.text.trim(),
                            'price': priceCtrl.text.trim().isEmpty ? '\$100 / night' : priceCtrl.text.trim(),
                            'status': 'Active',
                            'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
                          });
                        });
                        Navigator.pop(ctx);
                        AppFeedback.showSuccess(context, 'Listing "${titleCtrl.text}" published successfully!');
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filtered = _myListings.where((l) {
      final category = (l['category'] as String).toLowerCase();
      bool matchesCategory = true;
      if (_selectedCategory.contains('Hotels')) {
        matchesCategory = category == 'hotel';
      } else if (_selectedCategory.contains('Activities')) {
        matchesCategory = category == 'activity';
      } else if (_selectedCategory.contains('Trekking')) {
        matchesCategory = category == 'trekking';
      }

      final query = _searchQuery.toLowerCase();
      final matchesQuery = query.isEmpty ||
          (l['title'] as String).toLowerCase().contains(query) ||
          (l['location'] as String).toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
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
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Listings',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Manage your hotels, activities and services.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          color: isDark ? Colors.white54 : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: Text(
                      'Add Listing',
                      style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showAddListingSheet,
                  ),
                ],
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
                    hintText: 'Search your listings...',
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

              // Category Filter Chips
              SizedBox(
                height: 34,
                child: ListView.separated(
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

              const SizedBox(height: 14),

              // Listing Cards
              ...filtered.map((l) {
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
                          l['image'],
                          width: 64,
                          height: 64,
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
                                    l['title'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2563EB).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    l['category'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF2563EB),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF2563EB)),
                                const SizedBox(width: 2),
                                Text(
                                  l['location'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l['price'],
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF16A34A)),
                                    const SizedBox(width: 3),
                                    Text(
                                      l['status'],
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF16A34A),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFF16A34A), width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star_outline_rounded, size: 10, color: Color(0xFF16A34A)),
                                      const SizedBox(width: 2),
                                      Text(
                                        'Active',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
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
