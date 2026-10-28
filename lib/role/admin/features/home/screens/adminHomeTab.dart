import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';
import '../../profile/screens/adminNotificationsScreen.dart';
import '../../verification/screens/adminVerificationQueueScreen.dart';

class AdminHomeTab extends StatelessWidget {
  final VoidCallback onNavigateToQueue;

  const AdminHomeTab({
    super.key,
    required this.onNavigateToQueue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> recentRequests = const [
      {
        'title': 'Himalayan Escape Lodge',
        'location': 'Hotel • Kathmandu',
        'time': '2h ago',
        'status': 'Pending',
        'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
      },
      {
        'title': 'Everest Base Camp Trek',
        'location': 'Trekking • Solukhumbu',
        'time': '4h ago',
        'status': 'Pending',
        'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
      },
      {
        'title': 'Pokhara Valley Resort',
        'location': 'Hotel • Pokhara',
        'time': '6h ago',
        'status': 'Approved',
        'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
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
                            'Government Portal',
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
                                MaterialPageRoute(builder: (_) => const AdminNotificationsScreen()),
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
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0552A2),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.account_balance_rounded, size: 16, color: Color(0xFF0552A2)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Hero Greeting Banner
              Container(
                width: double.infinity,
                height: 125,
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
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Government Official',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Tourism Regulation & Verification',
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

              // 4 Grid Stat Cards (Total, Verified, Pending, Rejected)
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6,
                children: [
                  _buildStatTile(
                    title: 'Total Businesses',
                    value: '2,842',
                    trend: '↗ 12% vs. last month',
                    icon: Icons.storefront_rounded,
                    color: const Color(0xFF16A34A),
                    bgColor: const Color(0xFFDCFCE7),
                    isDark: isDark,
                  ),
                  _buildStatTile(
                    title: 'Verified',
                    value: '2,361',
                    trend: '83% of total',
                    icon: Icons.verified_rounded,
                    color: const Color(0xFF2563EB),
                    bgColor: const Color(0xFFEFF6FF),
                    isDark: isDark,
                  ),
                  _buildStatTile(
                    title: 'Pending Verification',
                    value: '421',
                    trend: '14.8%',
                    icon: Icons.pending_actions_rounded,
                    color: const Color(0xFFD97706),
                    bgColor: const Color(0xFFFEF3C7),
                    isDark: isDark,
                  ),
                  _buildStatTile(
                    title: 'Rejected',
                    value: '60',
                    trend: '2.1%',
                    icon: Icons.cancel_outlined,
                    color: const Color(0xFFEC1F27),
                    bgColor: const Color(0xFFFEE2E2),
                    isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Recent Verification Requests Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Verification Requests',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  GestureDetector(
                    onTap: onNavigateToQueue,
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

              // Verification List Items
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: recentRequests.map((r) {
                    final bool isPending = r['status'] == 'Pending';
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          dense: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AdminVerificationQueueScreen()),
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              r['image'],
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            r['title'],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          subtitle: Text(
                            '${r['location']} • ${r['time']}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5,
                              color: isDark ? Colors.white54 : const Color(0xFF64748B),
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? const Color(0xFFFEF3C7)
                                  : const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  r['status'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: isPending ? const Color(0xFFD97706) : const Color(0xFF16A34A),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 14,
                                  color: isPending ? const Color(0xFFD97706) : const Color(0xFF16A34A),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (recentRequests.indexOf(r) != recentRequests.length - 1)
                          Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF1F5F9)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile({
    required String title,
    required String value,
    required String trend,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required bool isDark,
  }) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 14),
              ),
              Text(
                trend,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: isDark ? Colors.white54 : const Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
