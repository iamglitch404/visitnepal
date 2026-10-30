import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class EditGuideProfileScreen extends StatefulWidget {
  const EditGuideProfileScreen({super.key});

  @override
  State<EditGuideProfileScreen> createState() => _EditGuideProfileScreenState();
}

class _EditGuideProfileScreenState extends State<EditGuideProfileScreen> {
  final TextEditingController _nameCtrl = TextEditingController(text: 'Pasang Nuru Sherpa');
  final TextEditingController _licenseCtrl = TextEditingController(text: 'TAAN-NMA-GUIDE-8821');
  final TextEditingController _summitsCtrl = TextEditingController(text: 'Everest 6x, Ama Dablam 3x, Manaslu 2x');
  final TextEditingController _langCtrl = TextEditingController(text: 'English, Nepali, Sherpa, French');
  final TextEditingController _rateCtrl = TextEditingController(text: '\$120 / day');
  final TextEditingController _emergencyCtrl = TextEditingController(text: 'Lakpa Sherpa (+977 9801122334)');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _licenseCtrl.dispose();
    _summitsCtrl.dispose();
    _langCtrl.dispose();
    _rateCtrl.dispose();
    _emergencyCtrl.dispose();
    super.dispose();
  }

  void _saveGuideProfile() {
    if (_nameCtrl.text.trim().isEmpty || _licenseCtrl.text.trim().isEmpty) {
      AppFeedback.showInfo(context, 'Name and License Number cannot be empty.');
      return;
    }

    AppFeedback.showSuccess(context, 'Guide Accreditation Profile updated!');
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Edit Guide Accreditation',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, fontSize: 15.5),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _saveGuideProfile,
            child: Text(
              'Save',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: const Color(0xFF0552A2)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(controller: _nameCtrl, label: 'Guide Full Name *', icon: Icons.person_outline_rounded, isDark: isDark),
              const SizedBox(height: 12),
              _buildInputField(controller: _licenseCtrl, label: 'NMA / TAAN License # *', icon: Icons.badge_outlined, isDark: isDark),
              const SizedBox(height: 12),
              _buildInputField(controller: _summitsCtrl, label: 'Himalayan Summits', icon: Icons.terrain_rounded, isDark: isDark),
              const SizedBox(height: 12),
              _buildInputField(controller: _langCtrl, label: 'Languages Spoken', icon: Icons.language_rounded, isDark: isDark),
              const SizedBox(height: 12),
              _buildInputField(controller: _rateCtrl, label: 'Daily Base Fee', icon: Icons.payments_rounded, isDark: isDark),
              const SizedBox(height: 12),
              _buildInputField(controller: _emergencyCtrl, label: 'Emergency Contact', icon: Icons.contact_phone_outlined, isDark: isDark),

              const SizedBox(height: 28),

              AppButton(
                text: 'Save Guide Profile',
                onPressed: _saveGuideProfile,
                width: double.infinity,
                height: 48,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(fontSize: 11.5, fontWeight: FontWeight.w700, color: isDark ? Colors.white70 : const Color(0xFF334155)),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: GoogleFonts.plusJakartaSans(fontSize: 12.5),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: const Color(0xFF64748B)),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.white12 : const Color(0xFFE2E8F0))),
          ),
        ),
      ],
    );
  }
}
