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
  final ScrollController _scrollCtrl = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchActive = false;
  String _searchQuery = '';
  final Set<String> _wishlisted = {'dest_ebc'};

  static final List<String> _recentSearches = [
    'Everest Base Camp Trek',
    'Pokhara Lakeside',
    'Annapurna Circuit',
    'Chitwan Wildlife Safari',
  ];

  static const List<Map<String, String>> _popularSearches = [
    {'label': 'Everest Trek', 'icon': '🏔️'},
    {'label': 'Pokhara Paragliding', 'icon': '🪂'},
    {'label': 'Chitwan Safari', 'icon': '🐅'},
    {'label': 'Kathmandu Durbar', 'icon': '🏛️'},
    {'label': 'Annapurna Circuit', 'icon': '🌄'},
    {'label': 'Lumbini Peace Garden', 'icon': '🌸'},
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _enterSearchMode() {
    if (!_isSearchActive) {
      setState(() {
        _isSearchActive = true;
      });
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          0.0,
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
        );
      }
    }
  }

  void _exitSearchMode() {
    setState(() {
      _isSearchActive = false;
      _searchCtrl.clear();
      _searchQuery = '';
    });
    _searchFocusNode.unfocus();
  }

  void _onSelectSearchItem(String query) {
    _searchCtrl.text = query;
    _searchCtrl.selection = TextSelection.fromPosition(TextPosition(offset: query.length));
    setState(() {
      _searchQuery = query;
      if (query.isNotEmpty && !_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
      }
    });
  }

  void _navigateToPackage(Map<String, dynamic> dest) {
    final title = dest['title'] as String? ?? '';
    if (title.isNotEmpty && !_recentSearches.contains(title)) {
      setState(() {
        _recentSearches.insert(0, title);
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PackageDetailScreen(package: dest),
      ),
    );
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
      floatingActionButton: _isSearchActive
          ? null
          : FloatingActionButton.extended(
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
          controller: _scrollCtrl,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting row with smooth collapse when search is activated
              AnimatedCrossFade(
                firstChild: Column(
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
                  ],
                ),
                secondChild: const SizedBox.shrink(),
                crossFadeState: _isSearchActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 240),
              ),

              // Search Bar row (smoothly glides to top place when search is activated)
              Row(
                children: [
                  if (_isSearchActive) ...[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        size: 22,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 48),
                      onPressed: _exitSearchMode,
                    ),
                    const SizedBox(width: 4),
                  ],

                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _isSearchActive
                              ? const Color(0xFF2563EB)
                              : (isDark ? Colors.white12 : const Color(0xFFE2E8F0)),
                          width: _isSearchActive ? 1.4 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isSearchActive
                                ? const Color(0xFF2563EB).withValues(alpha: 0.12)
                                : Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchCtrl,
                        focusNode: _searchFocusNode,
                        onTap: _enterSearchMode,
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val.trim();
                          });
                        },
                        onSubmitted: (val) {
                          final trimmed = val.trim();
                          if (trimmed.isNotEmpty) {
                            _onSelectSearchItem(trimmed);
                          }
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
                            color: _isSearchActive
                                ? const Color(0xFF2563EB)
                                : (isDark ? Colors.white54 : const Color(0xFF94A3B8)),
                          ),
                          suffixIcon: (_searchCtrl.text.isNotEmpty)
                              ? IconButton(
                                  icon: const Icon(Icons.clear_rounded, size: 18),
                                  onPressed: () {
                                    _searchCtrl.clear();
                                    setState(() {
                                      _searchQuery = '';
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

              const SizedBox(height: 18),

              // Down history & searched results, or discover feed
              if (_isSearchActive) ...[
                if (_searchQuery.isEmpty) ...[
                  _buildSearchHistory(theme, isDark),
                  const SizedBox(height: 22),
                  _buildPopularSearches(theme, isDark),
                ] else ...[
                  _buildSearchResults(theme, isDark),
                ],
              ] else ...[
                ..._buildDiscoverSections(theme, isDark),
              ],

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchHistory(ThemeData theme, bool isDark) {
    if (_recentSearches.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(Icons.search_rounded, size: 38, color: isDark ? Colors.white24 : const Color(0xFFCBD5E1)),
            const SizedBox(height: 8),
            Text(
              'Search treks, cities, stays & activities',
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white54 : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.history_rounded, size: 18, color: Color(0xFF2563EB)),
                const SizedBox(width: 6),
                Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                setState(() {
                  _recentSearches.clear();
                });
              },
              child: const Text(
                'Clear all',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFEF4444)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentSearches.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
          ),
          itemBuilder: (context, index) {
            final query = _recentSearches[index];
            return InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _onSelectSearchItem(query),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        query,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                      onPressed: () {
                        setState(() {
                          _recentSearches.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularSearches(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'POPULAR IN NEPAL',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: isDark ? Colors.white54 : const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _popularSearches.map((item) {
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => _onSelectSearchItem(item['label']!),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item['icon']!, style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 6),
                    Text(
                      item['label']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults(ThemeData theme, bool isDark) {
    final query = _searchQuery.toLowerCase();
    final results = MockData.destinations.where((d) {
      final title = (d['title'] as String? ?? '').toLowerCase();
      final loc = (d['location'] as String? ?? '').toLowerCase();
      final desc = (d['description'] as String? ?? '').toLowerCase();
      return title.contains(query) || loc.contains(query) || desc.contains(query);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Results (${results.length})',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            if (results.isNotEmpty)
              Text(
                'Tap to open details',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.white54 : const Color(0xFF64748B),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (results.isEmpty)
          const AppEmptyState(
            title: 'No Destinations Found',
            message: 'Try searching for Everest, Annapurna, Pokhara, or Chitwan.',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final dest = results[index];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _navigateToPackage(dest),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          dest['imageUrl'],
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 72,
                            height: 72,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.landscape_rounded, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dest['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF2563EB)),
                                const SizedBox(width: 3),
                                Expanded(
                                  child: Text(
                                    dest['location'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: isDark ? Colors.white60 : const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${dest['price']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: Color(0xFF16A34A),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${dest['rating'] ?? '4.9'}',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? Colors.white70 : const Color(0xFF475569),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: isDark ? Colors.white30 : const Color(0xFFCBD5E1),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  List<Widget> _buildDiscoverSections(ThemeData theme, bool isDark) {

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
