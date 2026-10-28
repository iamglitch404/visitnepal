import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';
import 'editBusinessProfileScreen.dart';
import '../../listings/screens/editListingsScreen.dart';

class BusinessProfileTab extends StatelessWidget {
  const BusinessProfileTab({super.key});

  void _showManageListingsSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> listings = [
      {'title': 'Himalayan Escape Lodge', 'type': 'Hotel & Resort', 'rate': '\$150 / night'},
      {'title': 'Everest Base Camp Trek', 'type': 'Trekking Route', 'rate': '\$1,200 / person'},
      {'title': 'Pokhara Sightseeing Tour', 'type': 'Place to Visit', 'rate': '\$80 / person'},
      {'title': 'Pasang Sherpa Guide Service', 'type': 'Mountain Guide', 'rate': '\$120 / day'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Manage Listings & Guides',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: listings.length,
                itemBuilder: (context, index) {
                  final item = listings[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0552A2).withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on_outlined, color: Color(0xFF0552A2), size: 18),
                      ),
                      title: Text(item['title']!, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 13.5)),
                      subtitle: Text('${item['type']} • ${item['rate']}', style: GoogleFonts.plusJakartaSans(fontSize: 11)),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Color(0xFF16A34A), size: 18),
                        onPressed: () {
                          AppFeedback.showInfo(context, 'Editing ${item['title']}');
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            AppButton(
              text: '+ Add New Place / Guide Listing',
              width: double.infinity,
              onPressed: () {
                Navigator.pop(ctx);
                AppFeedback.showSuccess(context, 'Opening Add New Listing form');
              },
            ),
            const SizedBox(height: 10),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Hero Mountain Header Banner
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=1200&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                ),

                // Edit Cover Pencil Icon
                Positioned(
                  top: 40,
                  right: 16,
                  child: GestureDetector(
                    onTap: () => AppFeedback.showInfo(context, 'Edit cover photo'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit_outlined, color: Colors.white, size: 16),
                    ),
                  ),
                ),

                // Floating Business Avatar
                Positioned(
                  bottom: -36,
                  left: 20,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(38),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF16A34A),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 42),

            // Business Info Title & Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Himalayan Escape Lodge',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 18),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Hotel & Resort',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 13, color: Color(0xFF2563EB)),
                      const SizedBox(width: 3),
                      Text(
                        'Kathmandu, Nepal',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          color: isDark ? Colors.white60 : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rating & Verified Business Badge
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFFDB716), size: 15),
                      const SizedBox(width: 3),
                      Text(
                        '4.8 ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        '(124 reviews)',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: isDark ? Colors.white54 : const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.verified_rounded, color: Color(0xFF16A34A), size: 12),
                            const SizedBox(width: 4),
                            Text(
                              'Verified Business',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 4 Quick Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Button 1: Edit Listings (Manage Places & Guides)
                      _buildActionButton(
                        context,
                        icon: Icons.list_alt_rounded,
                        label: 'Edit Listings',
                        color: const Color(0xFF2563EB),
                        bgColor: const Color(0xFFEFF6FF),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditListingsScreen())),
                        isDark: isDark,
                      ),
                      // Button 2: Edit Profile
                      _buildActionButton(
                        context,
                        icon: Icons.edit_note_rounded,
                        label: 'Edit Profile',
                        color: const Color(0xFF0552A2),
                        bgColor: const Color(0xFFEFF6FF),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditBusinessProfileScreen())),
                        isDark: isDark,
                      ),
                      // Button 3: Share
                      _buildActionButton(
                        context,
                        icon: Icons.share_outlined,
                        label: 'Share',
                        color: const Color(0xFF9333EA),
                        bgColor: const Color(0xFFF3E8FF),
                        onTap: () => AppFeedback.showSuccess(context, 'Profile link copied!'),
                        isDark: isDark,
                      ),
                      // Button 4: More
                      _buildActionButton(
                        context,
                        icon: Icons.more_horiz_rounded,
                        label: 'More',
                        color: const Color(0xFF64748B),
                        bgColor: const Color(0xFFF1F5F9),
                        onTap: () => AppFeedback.showInfo(context, 'More business options'),
                        isDark: isDark,
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Business Information Card
                  Text(
                    'Business Information',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          icon: Icons.storefront_outlined,
                          label: 'Business Name',
                          value: 'Himalayan Escape Lodge',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildInfoTile(
                          icon: Icons.category_outlined,
                          label: 'Category',
                          value: 'Hotel & Resort',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildInfoTile(
                          icon: Icons.location_on_outlined,
                          label: 'Location',
                          value: 'Kathmandu, Nepal',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildInfoTile(
                          icon: Icons.phone_outlined,
                          label: 'Contact',
                          value: '+977 9812345678',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildInfoTile(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: 'info@himalayanescape.com',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.shield_outlined, color: Color(0xFF16A34A), size: 16),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Verification Status ',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w700,
                                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                                          ),
                                        ),
                                        const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 12),
                                        Text(
                                          ' Verified',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF16A34A),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Your business is verified and trusted by travelers.',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        color: isDark ? Colors.white54 : const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? color.withValues(alpha: 0.15) : bgColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 44,
      endIndent: 14,
      color: isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFF1F5F9),
    );
  }
}
