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
            const Text(
              'Upcoming Bookings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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

  void _showPassportVisaSheet() {
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
            const Text('Passport & Travel Documents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFF3E8FF),
                child: Icon(Icons.badge_rounded, color: Color(0xFF7C3AED)),
              ),
              title: const Text('Passport Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Text(MockData.currentUser['passportNumber'] ?? 'NPL-9988221', style: const TextStyle(fontSize: 13)),
              trailing: const Icon(Icons.verified_rounded, color: Color(0xFF10B981)),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F2FE),
                child: Icon(Icons.airplane_ticket_rounded, color: Color(0xFF0284C7)),
              ),
              title: const Text('Tourist Visa (30 Days)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: const Text('Valid until 15 Jan 2027 • Tribhuvan Int. Airport entry', style: TextStyle(fontSize: 12)),
              trailing: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981)),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showPaymentsSheet() {
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
            const Text('Payment Methods & Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE6FDF4),
                child: Icon(Icons.credit_card_rounded, color: Color(0xFF10B981)),
              ),
              title: const Text('Visa ending in •••• 4242', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: const Text('Primary Payment Method • Exp 08/29', style: TextStyle(fontSize: 12)),
              trailing: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981)),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFEFF6FF),
                child: Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF2563EB)),
              ),
              title: const Text('eSewa / Khalti Digital Wallet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: const Text('Linked: +977 9841234567', style: TextStyle(fontSize: 12)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                AppFeedback.showInfo(context, 'Wallet linked successfully');
              },
            ),
            const SizedBox(height: 12),
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
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with optional back button and Settings Gear
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.showBackButton)
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(context),
                      )
                    else
                      const SizedBox.shrink(),
                    IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        color: isDark ? Colors.white70 : const Color(0xFF1E293B),
                        size: 26,
                      ),
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

              // 1. User Profile Header Row (Avatar, Name, Badge, Email, Member Since)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with Soft Glow & Blue Verified Checkmark Badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF818CF8), Color(0xFF60A5FA), Color(0xFF38BDF8)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF3B82F6).withValues(alpha: 0.25),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.network(
                              MockData.currentUser['avatar'],
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const CircleAvatar(
                                radius: 43,
                                backgroundColor: Color(0xFF3B82F6),
                                child: Icon(Icons.person, color: Colors.white, size: 44),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF0F172A) : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark ? const Color(0xFF0F172A) : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check_circle,
                                color: Color(0xFF0077D4),
                                size: 21,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

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
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Pro Explorer Badge Pill
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2FE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.explore_outlined,
                                  color: Color(0xFF0284C7),
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Pro Explorer',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0284C7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),

                          Text(
                            MockData.currentUser['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.white60 : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 3),

                          Text(
                            'Member since 2024',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 2. Stats Row (Upcoming Bookings, Permits, Offline Maps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    _buildStatColumn(
                      context,
                      count: '3',
                      label: 'Upcoming Bookings',
                      icon: Icons.calendar_month_outlined,
                      iconColor: const Color(0xFF3B82F6),
                      bgColor: const Color(0xFFEFF6FF),
                      onTap: _showBookingsSheet,
                      isDark: isDark,
                    ),
                    _buildVerticalDivider(isDark),
                    _buildStatColumn(
                      context,
                      count: '2',
                      label: 'Permits',
                      icon: Icons.explore_outlined,
                      iconColor: const Color(0xFF10B981),
                      bgColor: const Color(0xFFE6FDF4),
                      onTap: () => Navigator.pushNamed(context, '/permits'),
                      isDark: isDark,
                    ),
                    _buildVerticalDivider(isDark),
                    _buildStatColumn(
                      context,
                      count: '4',
                      label: 'Offline Maps',
                      icon: Icons.map_outlined,
                      iconColor: const Color(0xFF9333EA),
                      bgColor: const Color(0xFFF5EEFF),
                      onTap: () => AppFeedback.showInfo(context, '4 Offline Himalayan Region Maps Saved'),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // 3. NEXT TRIP Banner Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/hotels'),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F7FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white10 : const Color(0xFFE0EBF7),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F2FE),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'NEXT TRIP',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                    color: Color(0xFF0284C7),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Annapurna Base Camp Trek',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 13,
                                    color: isDark ? Colors.white60 : const Color(0xFF64748B),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '12 Nov 2026 – 20 Nov 2026',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: isDark ? Colors.white60 : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    size: 13,
                                    color: Color(0xFF0284C7),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Pokhara',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: isDark ? Colors.white60 : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: isDark ? Colors.white38 : const Color(0xFF64748B),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // 4. Menu List Items (Personal Information, Passport & Visa, Payments, Trek Permits, etc.)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // 1. Personal Information
                    _buildMenuItem(
                      icon: Icons.person_outline_rounded,
                      iconColor: const Color(0xFF3B82F6),
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
                      iconColor: const Color(0xFF8B5CF6),
                      iconBg: const Color(0xFFF5EEFF),
                      title: 'Passport & Visa',
                      subtitle: 'Manage your travel documents',
                      onTap: _showPassportVisaSheet,
                      isDark: isDark,
                    ),
                    _buildMenuDivider(isDark),

                    // 3. Payments
                    _buildMenuItem(
                      icon: Icons.credit_card_rounded,
                      iconColor: const Color(0xFF10B981),
                      iconBg: const Color(0xFFE6FDF4),
                      title: 'Payments',
                      subtitle: 'Cards, transactions, invoices',
                      onTap: _showPaymentsSheet,
                      isDark: isDark,
                    ),
                    _buildMenuDivider(isDark),

                    // 4. Trek Permits
                    _buildMenuItem(
                      icon: Icons.shield_outlined,
                      iconColor: const Color(0xFFF97316),
                      iconBg: const Color(0xFFFFF4EC),
                      title: 'Trek Permits',
                      subtitle: 'ACAP & TIMS permit status',
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
                      onTap: () => Navigator.pushNamed(context, '/notifications'),
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

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context, {
    required String count,
    required String label,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDark ? iconColor.withValues(alpha: 0.15) : bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 21),
              ),
              const SizedBox(height: 8),
              Text(
                count,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white60 : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider(bool isDark) {
    return Container(
      height: 46,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      dense: true,
      onTap: onTap,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: isDark ? iconColor.withValues(alpha: 0.15) : iconBg,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.white54 : const Color(0xFF64748B),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
        size: 22,
      ),
    );
  }

  Widget _buildMenuDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 58,
      endIndent: 4,
      color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F5F9),
    );
  }
}

