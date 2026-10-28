import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';
import 'editProfileScreen.dart';
import 'settingsScreen.dart';

class ProfileAccountScreen extends StatefulWidget {
  final bool showBackButton;

  const ProfileAccountScreen({super.key, this.showBackButton = false});

  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {
  void _openEditProfile() async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );
    if (updated == true) {
      setState(() {});
    }
  }

  void _showBookingsSheet() {
    final bookings = MockData.userBookings;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
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
            const SizedBox(height: 16),
            const Text('Upcoming Bookings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final b = bookings[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2563EB).withValues(alpha: 0.12),
                        child: const Icon(Icons.confirmation_number_rounded, color: Color(0xFF2563EB)),
                      ),
                      title: Text(b['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text('${b['id']} • ${b['date']}', style: const TextStyle(fontSize: 12)),
                      trailing: AppStatusChip(status: b['status']),
                      onTap: () {
                        Navigator.pop(ctx);
                        AppFeedback.showSuccess(context, 'Opening Boarding Pass QR Voucher');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
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
            const Text('Help & Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.question_answer_outlined, color: Color(0xFF14B8A6)),
              title: const Text('Frequently Asked Questions (FAQs)', style: TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                AppFeedback.showInfo(context, 'Opening FAQs...');
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined, color: Color(0xFF14B8A6)),
              title: const Text('Email Support (support@visitnepal.com)', style: TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                AppFeedback.showInfo(context, 'Support email copied');
              },
            ),
            ListTile(
              leading: const Icon(Icons.call_outlined, color: Color(0xFF14B8A6)),
              title: const Text('Tourist Helpline: +977 1 4247037', style: TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                AppFeedback.showInfo(context, 'Helpline number copied');
              },
            ),
            const SizedBox(height: 12),
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
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Mountain Header Banner Area
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Mountain Image Banner
                Container(
                  height: 210,
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
                          Colors.black.withValues(alpha: 0.55),
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black.withValues(alpha: 0.65),
                        ],
                      ),
                    ),
                  ),
                ),

                // Top Branding Header & Settings Gear
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand Logo
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (widget.showBackButton) ...[
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(width: 8),
                                ],
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
                                const Text(
                                  'VisitNepal',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Explore  •  Trek  •  Experience',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),

                        // Settings Icon
                        IconButton(
                          icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 24),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SettingsScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Floating Profile White Card Overlapping Mountain Header
                Padding(
                  padding: const EdgeInsets.only(top: 135.0, left: 16.0, right: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        // Avatar, User Info & Edit Profile Button Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar with Blue Verified Badge
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Image.network(
                                    MockData.currentUser['avatar'],
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(Icons.person, color: Colors.white, size: 36),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.verified_rounded,
                                      color: Color(0xFF2563EB),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 14),

                            // User Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MockData.currentUser['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    MockData.currentUser['email'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: isDark ? Colors.white60 : const Color(0xFF64748B),
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                  // Pro Explorer Badge Pill
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.workspace_premium_rounded, color: Color(0xFF2563EB), size: 13),
                                        SizedBox(width: 4),
                                        Text(
                                          'Pro Explorer',
                                          style: TextStyle(
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF2563EB),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 4),
                                  Text(
                                    'Member since 2024',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF1F5F9)),
                        const SizedBox(height: 14),

                        // 3 Column Stats Bar
                        Row(
                          children: [
                            _buildStatColumn(
                              context,
                              count: '3',
                              label: 'Upcoming Bookings',
                              onTap: _showBookingsSheet,
                              isDark: isDark,
                            ),
                            _buildVerticalDivider(isDark),
                            _buildStatColumn(
                              context,
                              count: '2',
                              label: 'Permits',
                              onTap: () => Navigator.pushNamed(context, '/permits'),
                              isDark: isDark,
                            ),
                            _buildVerticalDivider(isDark),
                            _buildStatColumn(
                              context,
                              count: '4',
                              label: 'Offline Maps',
                              onTap: () => AppFeedback.showInfo(context, '4 Offline Region Maps Saved'),
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 2. NEXT TRIP Banner Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
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
                          const Text(
                            'NEXT TRIP',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Annapurna Base Camp Trek',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined, size: 12, color: Color(0xFF64748B)),
                              const SizedBox(width: 4),
                              Text(
                                '12 Nov 2026 - 20 Nov 2026',
                                style: TextStyle(fontSize: 11, color: isDark ? Colors.white60 : const Color(0xFF64748B)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF2563EB)),
                              const SizedBox(width: 4),
                              Text(
                                'Pokhara',
                                style: TextStyle(fontSize: 11, color: isDark ? Colors.white60 : const Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3. Menu List Options Group
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      // 1. Personal Information
                      _buildMenuItem(
                        icon: Icons.person_outline_rounded,
                        iconColor: const Color(0xFF2563EB),
                        iconBg: const Color(0xFFEFF6FF),
                        title: 'Personal Information',
                        subtitle: 'Name, email, phone, nationality',
                        onTap: _openEditProfile,
                        isDark: isDark,
                      ),
                      _buildMenuDivider(isDark),

                      // 2. Passport & Visa
                      _buildMenuItem(
                        icon: Icons.language_rounded,
                        iconColor: const Color(0xFF7C3AED),
                        iconBg: const Color(0xFFF3E8FF),
                        title: 'Passport & Visa',
                        subtitle: 'Manage your travel documents',
                        onTap: () => Navigator.pushNamed(context, '/permits'),
                        isDark: isDark,
                      ),
                      _buildMenuDivider(isDark),

                      // 3. Payments
                      _buildMenuItem(
                        icon: Icons.credit_card_rounded,
                        iconColor: const Color(0xFF0D9488),
                        iconBg: const Color(0xFFCCFBF1),
                        title: 'Payments',
                        subtitle: 'Cards, transactions, invoices',
                        onTap: () => AppFeedback.showInfo(context, 'Payment options & billing receipts'),
                        isDark: isDark,
                      ),
                      _buildMenuDivider(isDark),

                      // 4. Trek Permits
                      _buildMenuItem(
                        icon: Icons.shield_outlined,
                        iconColor: const Color(0xFFEA580C),
                        iconBg: const Color(0xFFFFEDD5),
                        title: 'Trek Permits',
                        subtitle: 'ACAP & TIMS, permits status',
                        onTap: () => Navigator.pushNamed(context, '/permits'),
                        isDark: isDark,
                      ),
                      _buildMenuDivider(isDark),

                      // 5. Offline Maps
                      _buildMenuItem(
                        icon: Icons.map_outlined,
                        iconColor: const Color(0xFF0284C7),
                        iconBg: const Color(0xFFE0F2FE),
                        title: 'Offline Maps',
                        subtitle: 'Downloaded regions',
                        onTap: () => AppFeedback.showInfo(context, '4 Offline Himalayan Maps Ready'),
                        isDark: isDark,
                      ),
                      _buildMenuDivider(isDark),

                      // 6. Notifications
                      _buildMenuItem(
                        icon: Icons.notifications_none_rounded,
                        iconColor: const Color(0xFFE11D48),
                        iconBg: const Color(0xFFFFE4E6),
                        title: 'Notifications',
                        subtitle: 'Alerts, updates, reminders',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SettingsScreen()),
                          );
                        },
                        isDark: isDark,
                      ),
                      _buildMenuDivider(isDark),

                      // 7. Help & Support
                      _buildMenuItem(
                        icon: Icons.help_outline_rounded,
                        iconColor: const Color(0xFF475569),
                        iconBg: const Color(0xFFF1F5F9),
                        title: 'Help & Support',
                        subtitle: 'FAQs, contact us',
                        onTap: _showHelpSheet,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context, {
    required String count,
    required String label,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white60 : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalDivider(bool isDark) {
    return Container(
      height: 24,
      width: 1,
      color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      dense: true,
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? iconColor.withValues(alpha: 0.15) : iconBg,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11,
          color: isDark ? Colors.white54 : const Color(0xFF64748B),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
        size: 20,
      ),
    );
  }

  Widget _buildMenuDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 58,
      endIndent: 16,
      color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F5F9),
    );
  }
}
