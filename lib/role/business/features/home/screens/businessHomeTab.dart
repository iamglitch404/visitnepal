import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/data/mockData.dart';
import '../../../../../core/widgets/designSystem.dart';
import '../../notifications/screens/businessNotificationsScreen.dart';

class BusinessHomeTab extends StatelessWidget {
  final VoidCallback onNavigateToBookings;

  const BusinessHomeTab({
    super.key,
    required this.onNavigateToBookings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> recentBookings = const [
      {
        'name': 'Aarav Sharma',
        'location': 'Kathmandu • 2 nights',
        'status': 'Confirmed',
        'amount': '\$240',
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
      },
      {
        'name': 'Maya Gurung',
        'location': 'Pokhara • 1 night',
        'status': 'Pending',
        'amount': '\$120',
        'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
      },
      {
        'name': 'Rohan Thapa',
        'location': 'Lukla • 3 nights',
        'status': 'Confirmed',
        'amount': '\$360',
        'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
      },
      {
        'name': 'Sita Rai',
        'location': 'Chitwan • 2 nights',
        'status': 'Confirmed',
        'amount': '\$180',
        'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/svg/logo.jpeg',
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VisitNepal',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Business Owner',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white54 : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_none_rounded, size: 22),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const BusinessNotificationsScreen()),
                              );
                            },
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEC1F27),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=200&q=80',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Hero Lodge Greeting Banner
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.35),
                        Colors.black.withValues(alpha: 0.75),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Good Morning,',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Himalayan Escape Lodge',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF4ADE80),
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Here's what's happening with your business today.",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10.5,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // 3 Stat Cards Bar
              Row(
                children: [
                  _buildStatCard(
                    context,
                    icon: Icons.calendar_today_rounded,
                    iconColor: const Color(0xFF16A34A),
                    iconBg: const Color(0xFFDCFCE7),
                    title: 'Total Bookings',
                    value: '128',
                    subText: '↗ 12%\nvs. last month',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 8),
                  _buildStatCard(
                    context,
                    icon: Icons.attach_money_rounded,
                    iconColor: const Color(0xFF0552A2),
                    iconBg: const Color(0xFFEFF6FF),
                    title: 'Total Revenue',
                    value: '\$4,860',
                    subText: '↗ 8%\nvs. last month',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 8),
                  _buildStatCard(
                    context,
                    icon: Icons.star_rounded,
                    iconColor: const Color(0xFFFDB716),
                    iconBg: const Color(0xFFFEF9C3),
                    title: 'Rating',
                    value: '4.8',
                    subText: '(124)',
                    isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Recent Bookings Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Bookings',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  GestureDetector(
                    onTap: onNavigateToBookings,
                    child: Text(
                      'View all →',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0552A2),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Recent Bookings List
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: recentBookings.map((b) {
                    final bool isConfirmed = b['status'] == 'Confirmed';
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          dense: true,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              b['avatar'],
                              width: 38,
                              height: 38,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            b['name'],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          subtitle: Text(
                            b['location'],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5,
                              color: isDark ? Colors.white54 : const Color(0xFF64748B),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isConfirmed
                                      ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                                      : const Color(0xFFFDB716).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  b['status'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: isConfirmed ? const Color(0xFF16A34A) : const Color(0xFFD97706),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                b['amount'],
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (recentBookings.indexOf(b) != recentBookings.length - 1)
                          Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF1F5F9)),
                      ],
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Grow Your Business Promo Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFF0552A2).withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Grow Your Business',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0552A2),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Get more bookings with better visibility on VisitNepal.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5,
                              color: isDark ? Colors.white60 : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF16A34A),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => AppFeedback.showInfo(context, 'Business Growth Tips loaded!'),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View Tips ',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 10.5, fontWeight: FontWeight.bold),
                                ),
                                const Icon(Icons.arrow_forward_rounded, size: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.landscape_rounded, size: 48, color: Color(0xFF92C4EA)),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String value,
    required String subText,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 14),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: isDark ? Colors.white54 : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subText,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF16A34A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
