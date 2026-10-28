import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Government Official Header Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0552A2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_outline_rounded, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Government Official',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tourism Regulation & Verification\nMinistry of Culture, Tourism and Civil Aviation',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5,
                              color: isDark ? Colors.white54 : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Options Group
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildOptionTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Account Settings',
                      subtitle: 'Manage your profile and credentials',
                      onTap: () => AppFeedback.showInfo(context, 'Account settings'),
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildOptionTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notification Preferences',
                      subtitle: 'Choose what you want to be notified about',
                      onTap: () => AppFeedback.showInfo(context, 'Notification settings'),
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildOptionTile(
                      icon: Icons.verified_user_outlined,
                      title: 'Verification Settings',
                      subtitle: 'Manage verification rules and requirements',
                      onTap: () => AppFeedback.showInfo(context, 'Verification settings'),
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildOptionTile(
                      icon: Icons.tune_rounded,
                      title: 'App Preferences',
                      subtitle: 'Language, theme, and more',
                      onTap: () => AppFeedback.showInfo(context, 'App preferences'),
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildOptionTile(
                      icon: Icons.help_outline_rounded,
                      title: 'Help & Support',
                      subtitle: 'FAQs, contact support',
                      onTap: () => AppFeedback.showInfo(context, 'NTB Official Support'),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Log Out Button
              ListTile(
                onTap: () {
                  AppFeedback.showInfo(context, 'Signed out from Government Portal');
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                leading: const Icon(Icons.logout_rounded, color: Color(0xFFEC1F27), size: 20),
                title: Text(
                  'Log Out',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFEC1F27),
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

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      dense: true,
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: const Color(0xFF0552A2).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF0552A2), size: 18),
      ),
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10.5,
          color: isDark ? Colors.white54 : const Color(0xFF64748B),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
        size: 18,
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 48,
      endIndent: 14,
      color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F5F9),
    );
  }
}
