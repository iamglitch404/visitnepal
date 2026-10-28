import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';
import '../widgets/userPostCard.dart';
import '../widgets/discoverServicesGrid.dart';
import '../widgets/discoverPlannerBanner.dart';
import '../widgets/discoverAttractionCard.dart';
import '../../destinations/screens/packageDetailScreen.dart';
import '../../destinations/screens/destinationsTab.dart';
import 'notificationsScreen.dart';
import 'createPostScreen.dart';
import '../../chat/screens/chatScreen.dart';
import '../../services/screens/hotelsScreen.dart';
import '../../services/screens/guidesScreen.dart';
import '../../services/screens/butlerScreen.dart';
import '../../services/screens/activitiesScreen.dart';
import '../../services/screens/permitsScreen.dart';

class DiscoverTab extends StatefulWidget {
  final Function(String)? onSelectPackage;

  const DiscoverTab({super.key, this.onSelectPackage});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  final TextEditingController _searchCtrl = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';
  final Set<String> _wishlisted = {'dest_ebc'};

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onServiceSelected(String category) {
    switch (category) {
      case 'permits':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PermitsScreen()));
        break;
      case 'hotels':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HotelsScreen()));
        break;
      case 'transport':
        AppFeedback.showInfo(context, 'Browsing Transport & 4x4 options');
        break;
      case 'guides':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const GuidesScreen()));
        break;
      case 'activities':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ActivitiesScreen()));
        break;
      case 'butler':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ButlerScreen()));
        break;
      default:
        AppFeedback.showInfo(context, 'Browsing $category services');
        break;
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 16),
            const Text('Filter Treks & Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Trekking', 'Wildlife', 'Cultural', 'Adventure', 'Easy', 'Challenging']
                  .map((f) => FilterChip(
                        label: Text(f),
                        selected: false,
                        onSelected: (_) {
                          Navigator.pop(ctx);
                          AppFeedback.showInfo(context, 'Filter applied: $f');
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreatePostScreen(
                onPostCreated: (_) => setState(() {}),
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFF16A34A),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: const Text(
          'Add Story',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Namaste, Traveler 🙏',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          size: 24,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 22,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ChatScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
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
                      child: TextField(
                        controller: _searchCtrl,
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val.trim();
                            _isSearching = _searchQuery.isNotEmpty;
                          });
                        },
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Explore Nepal',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 20,
                            color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
                          ),
                          suffixIcon: _isSearching
                              ? IconButton(
                                  icon: const Icon(Icons.clear_rounded, size: 18),
                                  onPressed: () {
                                    _searchCtrl.clear();
                                    setState(() {
                                      _searchQuery = '';
                                      _isSearching = false;
                                    });
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: _showFilterSheet,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
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
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/filter.svg',
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                            isDark ? Colors.white70 : const Color(0xFF334155),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ..._buildDiscoverSections(theme, isDark),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDiscoverSections(ThemeData theme, bool isDark) {
    if (_isSearching) {
      final results = MockData.destinations
          .where((d) => (d['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

      if (results.isEmpty) {
        return const [
          Text(
            'Search Results',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          AppEmptyState(
            title: 'No Results Found',
            message: 'Try searching for Everest, Annapurna, or Pokhara.',
          ),
        ];
      }

      return [
        Text(
          'Search Results for "$_searchQuery"',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...results.map(
          (dest) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: AppCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PackageDetailScreen(package: dest),
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(dest['imageUrl'], width: 70, height: 70, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dest['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(dest['location'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                        const SizedBox(height: 4),
                        Text('\$${dest['price']}', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ),
      ];
    }

    return [
      DiscoverServicesGrid(
        onServiceSelected: _onServiceSelected,
      ),

      const SizedBox(height: 20),

      const DiscoverPlannerBanner(),

      const SizedBox(height: 24),

      Text(
        'Where would you like to visit?',
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
        ),
      ),

      const SizedBox(height: 28),

      Center(
        child: Text(
          'No places added yet.',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
          ),
        ),
      ),

      const SizedBox(height: 28),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popular Attractions',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DestinationsTab()),
              );
            },
            child: const Text(
              'View all >',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2563EB),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 14),

      SizedBox(
        height: 240,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: MockData.destinations.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final dest = MockData.destinations[index];
            final id = dest['id'] ?? '';
            final isSaved = _wishlisted.contains(id);

            return DiscoverAttractionCard(
              dest: dest,
              isSaved: isSaved,
              onBookmarkTap: () {
                setState(() {
                  if (isSaved) {
                    _wishlisted.remove(id);
                    AppFeedback.showInfo(context, 'Removed from Saved Places');
                  } else {
                    _wishlisted.add(id);
                    AppFeedback.showSuccess(context, 'Added to Saved Places');
                  }
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PackageDetailScreen(package: dest)),
                );
              },
            );
          },
        ),
      ),

      const SizedBox(height: 24),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text(
        'Traveler Community Feed',
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w800,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
        ],
      ),
      const SizedBox(height: 12),
      ...MockData.communityPosts.map((post) => UserPostCard(post: post)),
    ];
  }
}
