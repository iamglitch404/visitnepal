import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class EditBusinessProfileScreen extends StatefulWidget {
  const EditBusinessProfileScreen({super.key});

  @override
  State<EditBusinessProfileScreen> createState() => _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState extends State<EditBusinessProfileScreen> {
  final TextEditingController _companyCtrl = TextEditingController(text: 'Himalayan Escape Lodge');
  final TextEditingController _categoryCtrl = TextEditingController(text: 'Hotel & Resort');
  final TextEditingController _locationCtrl = TextEditingController(text: 'Durbar Marg, Kathmandu, Nepal');
  final TextEditingController _phoneCtrl = TextEditingController(text: '+977 9812345678');
  final TextEditingController _emailCtrl = TextEditingController(text: 'info@himalayanescape.com');
  final TextEditingController _regCtrl = TextEditingController(text: 'CRO-9988221');
  final TextEditingController _panCtrl = TextEditingController(text: 'PAN-601234567');
  final TextEditingController _citizenshipCtrl = TextEditingController(text: 'NPL-27-01-78-01234');
  final TextEditingController _rateCtrl = TextEditingController(text: '\$150 / night');
  final TextEditingController _capacityCtrl = TextEditingController(text: '24 Deluxe Rooms');

  bool _docsUploaded = true;
  String _logoUrl = 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80';

  @override
  void dispose() {
    _companyCtrl.dispose();
    _categoryCtrl.dispose();
    _locationCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _regCtrl.dispose();
    _panCtrl.dispose();
    _citizenshipCtrl.dispose();
    _rateCtrl.dispose();
    _capacityCtrl.dispose();
    super.dispose();
  }

  void _saveBusinessProfile() {
    if (_companyCtrl.text.trim().isEmpty || _emailCtrl.text.trim().isEmpty) {
      AppFeedback.showInfo(context, 'Business name and email cannot be empty');
      return;
    }

    if (_panCtrl.text.trim().isEmpty || _citizenshipCtrl.text.trim().isEmpty) {
      AppFeedback.showInfo(context, 'PAN Number and Nepali Citizenship ID are required.');
      return;
    }

    AppFeedback.showSuccess(context, 'Business Profile & Legal Docs updated successfully!');
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
          'Edit Business Profile',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, fontSize: 15.5),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _saveBusinessProfile,
            child: Text(
              'Save',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: const Color(0xFF0552A2),
              ),
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
              // Logo Header Picker
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0552A2),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              _logoUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              AppFeedback.showInfo(context, 'Logo photo updated');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0552A2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap camera icon to change business logo',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: isDark ? Colors.white54 : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Section 1: Business Identity
              _buildSectionTitle('BUSINESS IDENTITY', isDark),
              const SizedBox(height: 10),

              _buildInputField(
                controller: _companyCtrl,
                label: 'Business / Lodge Name *',
                icon: Icons.storefront_outlined,
                isDark: isDark,
              ),
              const SizedBox(height: 12),

              _buildInputField(
                controller: _categoryCtrl,
                label: 'Business Category *',
                icon: Icons.category_outlined,
                isDark: isDark,
              ),

              const SizedBox(height: 20),

              // Section 2: Legal Registration & Nepali Gov ID
              _buildSectionTitle('LEGAL REGISTRATION & NEPALI GOV ID', isDark),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _regCtrl,
                      label: 'Company Reg # *',
                      icon: Icons.badge_outlined,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      controller: _panCtrl,
                      label: 'PAN / VAT # *',
                      icon: Icons.assignment_outlined,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildInputField(
                controller: _citizenshipCtrl,
                label: 'Nepali Citizenship ID / National ID *',
                icon: Icons.verified_user_outlined,
                isDark: isDark,
              ),

              const SizedBox(height: 12),

              // Upload Registration & PAN Certificate Card
              GestureDetector(
                onTap: () {
                  setState(() {
                    _docsUploaded = !_docsUploaded;
                  });
                  AppFeedback.showSuccess(context, _docsUploaded ? 'Business Registration & PAN certificates uploaded!' : 'Certificates removed');
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _docsUploaded ? const Color(0xFF16A34A) : Colors.grey.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _docsUploaded ? Icons.task_alt_rounded : Icons.cloud_upload_outlined,
                        color: _docsUploaded ? const Color(0xFF16A34A) : const Color(0xFF0552A2),
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _docsUploaded ? 'PAN & Registration Scans Uploaded ✓' : 'Upload Firm Reg & PAN Scans',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _docsUploaded ? const Color(0xFF16A34A) : (isDark ? Colors.white : const Color(0xFF0F172A)),
                              ),
                            ),
                            Text(
                              _docsUploaded ? 'company_reg_and_pan_cert.pdf (Verified by NTB)' : 'Tap to select PDF or image scans',
                              style: TextStyle(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Section 3: Contact & Location
              _buildSectionTitle('CONTACT & LOCATION', isDark),
              const SizedBox(height: 10),

              _buildInputField(
                controller: _locationCtrl,
                label: 'Location / Address',
                icon: Icons.location_on_outlined,
                isDark: isDark,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _phoneCtrl,
                      label: 'Contact Phone',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      controller: _emailCtrl,
                      label: 'Business Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Section 4: Pricing & Capacity
              _buildSectionTitle('PRICING & CAPACITY', isDark),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _rateCtrl,
                      label: 'Base Nightly Rate',
                      icon: Icons.attach_money_rounded,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      controller: _capacityCtrl,
                      label: 'Total Capacity',
                      icon: Icons.king_bed_outlined,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Save Button
              AppButton(
                text: 'Save Business Profile',
                onPressed: _saveBusinessProfile,
                width: double.infinity,
                height: 48,
              ),

              const SizedBox(height: 24),
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
        letterSpacing: 0.8,
        color: isDark ? Colors.white54 : const Color(0xFF64748B),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white70 : const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.plusJakartaSans(fontSize: 12.5),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: const Color(0xFF64748B)),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
