import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adminSettingsScreen.dart';

class AdminProfileTab extends StatelessWidget {
  const AdminProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Government Profile',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Official Nepal Emblem Logo Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 36,
                  backgroundColor: Color(0xFF0552A2),
                  child: Icon(Icons.account_balance_rounded, color: Colors.white, size: 38),
                ),
              ),

              const SizedBox(height: 14),

              Text(
                'Ministry of Culture, Tourism\nand Civil Aviation',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Government of Nepal',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFEC1F27),
                ),
              ),

              const SizedBox(height: 22),

              // Official Details Card
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Official Details',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
              ),

              const SizedBox(height: 10),

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
                  children: [
                    _buildInfoTile(
                      icon: Icons.domain_outlined,
                      label: 'Department',
                      value: 'Tourism Management Division',
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildInfoTile(
                      icon: Icons.location_on_outlined,
                      label: 'Address',
                      value: 'Singha Durbar, Kathmandu',
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildInfoTile(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: '+977-1-4211234',
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildInfoTile(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'tourism@molctca.gov.np',
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildInfoTile(
                      icon: Icons.language_outlined,
                      label: 'Website',
                      value: 'www.tourism.gov.np',
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Our Mission Card Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF16A34A).withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF16A34A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.explore_rounded, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Our Mission',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Promote sustainable tourism and ensure quality, safe and authorized tourism services across Nepal.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5,
                              color: isDark ? Colors.white70 : const Color(0xFF475569),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
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
