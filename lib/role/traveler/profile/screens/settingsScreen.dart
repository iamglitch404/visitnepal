import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/designSystem.dart';
import '../../../../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _biometrics = true;
  String _selectedCurrency = 'USD (\$)';
  String _selectedLanguage = 'English';

  final List<Color> _accentColors = const [
    Color(0xFF0552A2), // Royal Nepal Blue
    Color(0xFFEC1F27), // Crimson Nepal Red
    Color(0xFF92C4EA), // Sky Glacier Blue
    Color(0xFFFDB716), // Golden Yellow
    Color(0xFF9333EA), // Royal Purple
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Settings & Preferences',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            letterSpacing: -0.2,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Appearance & Theme
              _buildSectionTitle('APPEARANCE & THEME', isDark),
              const SizedBox(height: 6),
              _buildCardContainer(
                isDark: isDark,
                children: [
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    dense: true,
                    secondary: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.dark_mode_outlined, color: Color(0xFF2563EB), size: 15),
                    ),
                    title: Text(
                      'Dark Mode',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    subtitle: Text(
                      'Toggle application color theme',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5,
                        color: isDark ? Colors.white54 : const Color(0xFF64748B),
                      ),
                    ),
                    value: VisitNepalApp.themeModeNotifier.value == ThemeMode.dark,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (val) {
                      VisitNepalApp.themeModeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                      setState(() {});
                    },
                  ),
                  _buildDividerLine(isDark),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Accent Color',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _accentColors.map((color) {
                            final isSelected = VisitNepalApp.accentColorNotifier.value.toARGB32() == color.toARGB32();
                            return GestureDetector(
                              onTap: () {
                                VisitNepalApp.accentColorNotifier.value = color;
                                setState(() {});
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.white : Colors.transparent,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    if (isSelected)
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.5),
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                      ),
                                  ],
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check, color: Colors.white, size: 15)
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Section 2: Regional Preferences
              _buildSectionTitle('REGIONAL PREFERENCES', isDark),
              const SizedBox(height: 6),
              _buildCardContainer(
                isDark: isDark,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    dense: true,
                    leading: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.attach_money_rounded, color: Color(0xFF16A34A), size: 15),
                    ),
                    title: Text(
                      'Currency',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    trailing: DropdownButton<String>(
                      value: _selectedCurrency,
                      underline: const SizedBox(),
                      items: ['USD (\$)', 'NPR (रु)', 'EUR (€)', 'GBP (£)']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c, style: GoogleFonts.plusJakartaSans(fontSize: 11))))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedCurrency = val!),
                    ),
                  ),
                  _buildDividerLine(isDark),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    dense: true,
                    leading: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEC1F27).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.language_rounded, color: Color(0xFFEC1F27), size: 15),
                    ),
                    title: Text(
                      'Language',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      underline: const SizedBox(),
                      items: ['English', 'नेपाली (Nepali)', 'Français', 'Deutsch']
                          .map((l) => DropdownMenuItem(value: l, child: Text(l, style: GoogleFonts.plusJakartaSans(fontSize: 11))))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedLanguage = val!),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Section 3: Notifications & Security
              _buildSectionTitle('NOTIFICATIONS & SECURITY', isDark),
              const SizedBox(height: 6),
              _buildCardContainer(
                isDark: isDark,
                children: [
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    dense: true,
                    secondary: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_outlined, color: Color(0xFF10B981), size: 15),
                    ),
                    title: Text(
                      'Push Notifications',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    subtitle: Text(
                      'Trek alerts and booking updates',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5,
                        color: isDark ? Colors.white54 : const Color(0xFF64748B),
                      ),
                    ),
                    value: _notifications,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (val) => setState(() => _notifications = val),
                  ),
                  _buildDividerLine(isDark),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    dense: true,
                    secondary: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.fingerprint_rounded, color: Color(0xFF8B5CF6), size: 15),
                    ),
                    title: Text(
                      'Biometric Security',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    subtitle: Text(
                      'Unlock app with Face ID or Fingerprint',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5,
                        color: isDark ? Colors.white54 : const Color(0xFF64748B),
                      ),
                    ),
                    value: _biometrics,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (val) => setState(() => _biometrics = val),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Section 4: About & Support
              _buildSectionTitle('ABOUT & SUPPORT', isDark),
              const SizedBox(height: 6),
              _buildCardContainer(
                isDark: isDark,
                children: [
                  _buildListOption(
                    icon: Icons.headset_mic_outlined,
                    iconColor: const Color(0xFF14B8A6),
                    title: 'Help & Tourist Helpline',
                    subtitle: 'FAQs & NTB Support +977 1 4247037',
                    onTap: () => AppFeedback.showInfo(context, 'Tourist Helpline: +977 1 4247037'),
                    isDark: isDark,
                  ),
                  _buildDividerLine(isDark),
                  _buildListOption(
                    icon: Icons.description_outlined,
                    iconColor: const Color(0xFF64748B),
                    title: 'Terms & Privacy Policy',
                    subtitle: 'Read Nepal Tourism Board regulations',
                    onTap: () => AppFeedback.showInfo(context, 'Visit Nepal Terms & Privacy'),
                    isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // App Version Footer
              Center(
                child: Column(
                  children: [
                    Text(
                      'VISIT NEPAL',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Version 1.0.0+1 (Himalayan Edition)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5,
                        color: isDark ? Colors.white30 : const Color(0xFFCBD5E1),
                      ),
                    ),
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

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 9.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
        color: isDark ? Colors.white54 : const Color(0xFF64748B),
      ),
    );
  }

  Widget _buildCardContainer({required List<Widget> children, required bool isDark}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: Column(children: children),
      ),
    );
  }

  Widget _buildListOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      dense: true,
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 15),
      ),
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 9.5,
          color: isDark ? Colors.white54 : const Color(0xFF64748B),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
        size: 16,
      ),
    );
  }

  Widget _buildDividerLine(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 42,
      endIndent: 12,
      color: isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFF1F5F9),
    );
  }
}
