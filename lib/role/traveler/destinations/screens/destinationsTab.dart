import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';
import '../widgets/popularDestinationCard.dart';
import 'package:visitnepal/role/traveler/destinations/screens/packageDetailScreen.dart';

class DestinationsTab extends StatefulWidget {
  final Function(String)? onSelectPackage;

  const DestinationsTab({super.key, this.onSelectPackage});

  @override
  State<DestinationsTab> createState() => _DestinationsTabState();
}

class _DestinationsTabState extends State<DestinationsTab> {
  String _selectedDifficulty = 'All';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _difficulties = ['All', 'Easy', 'Moderate', 'Difficult', 'Challenging'];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredDestinations {
    return MockData.destinations.where((d) {
      final matchesDiff = _selectedDifficulty == 'All' || d['difficulty'] == _selectedDifficulty;
      final matchesQuery = _searchQuery.isEmpty ||
          (d['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (d['location'] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesDiff && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filtered = _filteredDestinations;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore Himalayas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.3),
              ),
              const SizedBox(height: 4),
              Text(
                'Discover legendary trekking circuits, lakes & sacred valleys',
                style: TextStyle(fontSize: 11.5, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _searchCtrl,
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
                decoration: InputDecoration(
                  hintText: 'Search Everest, Annapurna, Mustang...',
                  hintStyle: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _difficulties.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final diff = _difficulties[index];
                    final isSelected = _selectedDifficulty == diff;
                    return ChoiceChip(
                      label: Text(diff),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedDifficulty = diff),
                      selectedColor: theme.colorScheme.primary,
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                      ),
                      backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              if (_searchQuery.isEmpty && _selectedDifficulty == 'All') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Featured Expeditions', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800)),
                    Text(
                      '${MockData.destinations.length} routes',
                      style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 228,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: MockData.destinations.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final dest = MockData.destinations[index];
                      return PopularDestinationCard(
                        destination: dest,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PackageDetailScreen(package: dest),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],

              Text(
                _searchQuery.isNotEmpty ? 'Search Results (${filtered.length})' : 'All Trekking Packages',
                style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),

              if (filtered.isEmpty)
                const AppEmptyState(
                  title: 'No Routes Found',
                  message: 'Try adjusting your search query or difficulty filter.',
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 650;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isWide ? 3 : 1,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: isWide ? 0.85 : 1.28,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final dest = filtered[index];
                        return AppCard(
                          padding: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PackageDetailScreen(package: dest),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      dest['imageUrl'],
                                      height: isWide ? 140 : 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.7),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                                            const SizedBox(width: 3),
                                            Text(
                                              '${dest['rating']}',
                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary.withValues(alpha: 0.9),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          dest['difficulty'],
                                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dest['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      dest['location'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.terrain_rounded, size: 14, color: Color(0xFF16A34A)),
                                            const SizedBox(width: 4),
                                            Text(dest['altitude'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        Text(
                                          '\$${dest['price']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: theme.colorScheme.primary,
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
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
