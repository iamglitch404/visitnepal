import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../widgets/bookingItemCard.dart';
import 'bookingDetailScreen.dart';

class BookingsTab extends StatefulWidget {
  final VoidCallback? onNavigateToChat;
  final VoidCallback? onBack;

  const BookingsTab({super.key, this.onNavigateToChat, this.onBack});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  int _selectedTabIndex = 0; // 0: Booked, 1: History
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    if (_selectedTabIndex != index) {
      setState(() {
        _selectedTabIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openBookingDetails(BuildContext context, Map<String, dynamic> booking) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => BookingDetailScreen(booking: booking),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 320),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final allBookings = MockData.userBookings;
    final query = _searchQuery.toLowerCase();

    final bookedList = allBookings.where((b) {
      final status = (b['status'] as String? ?? '').toLowerCase();
      final isBooked = status.contains('confirmed') || status.contains('booked');
      final matchesQuery = query.isEmpty ||
          (b['title'] as String).toLowerCase().contains(query) ||
          (b['id'] as String).toLowerCase().contains(query);
      return isBooked && matchesQuery;
    }).toList();

    final historyList = allBookings.where((b) {
      final status = (b['status'] as String? ?? '').toLowerCase();
      final isHistory = status.contains('completed') || status.contains('cancel');
      final matchesQuery = query.isEmpty ||
          (b['title'] as String).toLowerCase().contains(query) ||
          (b['id'] as String).toLowerCase().contains(query);
      return isHistory && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Header Bar: Title "My Booking"
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 16, right: 16, bottom: 8),
              child: Center(
                child: Text(
                  'My Booking',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
              ),
            ),

            // 2. Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchCtrl,
                        onChanged: (val) => setState(() => _searchQuery = val.trim()),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchCtrl.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Icon(Icons.close_rounded, size: 18, color: Color(0xFF94A3B8)),
                        ),
                      ),
                    const Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: Color(0xFF94A3B8),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Segmented Tabs: "Booked" vs "History" (Smooth Sliding Pill Indicator)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, _) {
                    double page = _selectedTabIndex.toDouble();
                    if (_pageController.hasClients && _pageController.position.hasContentDimensions) {
                      page = _pageController.page ?? page;
                    }
                    final clampedPage = page.clamp(0.0, 1.0);
                    final alignX = (clampedPage * 2.0) - 1.0;
                    final bookedT = 1.0 - clampedPage;
                    final historyT = clampedPage;
                    final activeColor = isDark ? Colors.white : const Color(0xFF0F172A);
                    const inactiveColor = Color(0xFF94A3B8);

                    return Stack(
                      children: [
                        // Smooth Sliding White Pill Indicator
                        Align(
                          alignment: Alignment(alignX, 0.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            heightFactor: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF334155) : Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Tap Targets & Labels
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _onTabChanged(0),
                                behavior: HitTestBehavior.opaque,
                                child: Center(
                                  child: Text(
                                    'Booked',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: bookedT > 0.5 ? FontWeight.w700 : FontWeight.w500,
                                      color: Color.lerp(inactiveColor, activeColor, bookedT),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _onTabChanged(1),
                                behavior: HitTestBehavior.opaque,
                                child: Center(
                                  child: Text(
                                    'History',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: historyT > 0.5 ? FontWeight.w700 : FontWeight.w500,
                                      color: Color.lerp(inactiveColor, activeColor, historyT),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // 4. Content: Smooth Sliding Pages (PageView for Booked and History)
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                    PointerDeviceKind.stylus,
                  },
                ),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (_selectedTabIndex != index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildBookingsList(bookedList, isDark),
                    _buildBookingsList(historyList, isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsList(List<Map<String, dynamic>> list, bool isDark) {
    if (list.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bookmark_border_rounded,
                size: 76,
                color: isDark ? Colors.white24 : const Color(0xFFCBD5E1),
              ),
              const SizedBox(height: 16),
              Text(
                'No bookings found',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "You don't have any bookings yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final b = list[index];
        return BookingItemCard(
          booking: b,
          onTap: () => _openBookingDetails(context, b),
        );
      },
    );
  }
}


