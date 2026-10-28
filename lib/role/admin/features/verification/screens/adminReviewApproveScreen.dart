import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';
import 'adminVerificationStatusScreen.dart';

class AdminReviewApproveScreen extends StatefulWidget {
  final String businessName;

  const AdminReviewApproveScreen({
    super.key,
    this.businessName = 'Himalayan Escape Lodge',
  });

  @override
  State<AdminReviewApproveScreen> createState() => _AdminReviewApproveScreenState();
}

class _AdminReviewApproveScreenState extends State<AdminReviewApproveScreen> {
  int _selectedTab = 0; // 0: Documents, 1: Additional Info

  bool _c1 = true;
  bool _c2 = true;
  bool _c3 = true;
  bool _c4 = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Review & Approve',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Business Card Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=200&q=80',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.businessName,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Hotel & Resort',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: isDark ? Colors.white70 : const Color(0xFF475569),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, size: 11, color: Color(0xFF2563EB)),
                              const SizedBox(width: 2),
                              Text(
                                'Kathmandu, Bagmati Province',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.5,
                                  color: isDark ? Colors.white54 : const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Segmented Tab Bar (Documents vs Additional Info)
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 0 ? const Color(0xFF16A34A) : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                        ),
                        child: Text(
                          'Documents',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: _selectedTab == 0 ? FontWeight.w800 : FontWeight.w600,
                            color: _selectedTab == 0 ? const Color(0xFF16A34A) : (isDark ? Colors.white54 : const Color(0xFF64748B)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 1 ? const Color(0xFF16A34A) : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                        ),
                        child: Text(
                          'Additional Info',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: _selectedTab == 1 ? FontWeight.w800 : FontWeight.w600,
                            color: _selectedTab == 1 ? const Color(0xFF16A34A) : (isDark ? Colors.white54 : const Color(0xFF64748B)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (_selectedTab == 0) ...[
                // Uploaded Documents List
                _buildDocItem('Business Registration Certificate', 'View file', isDark),
                const SizedBox(height: 10),
                _buildDocItem('PAN Card', 'View file', isDark),
                const SizedBox(height: 10),
                _buildDocItem('Property Ownership / Lease Agreement', 'View file', isDark),
                const SizedBox(height: 10),
                _buildDocItem('Photos (Property & Facilities)', 'View all (5)', isDark),

                const SizedBox(height: 20),

                // Verification Checklist
                Text(
                  'Verification Checklist',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),

                _buildCheckRow('Valid business registration', _c1, (v) => setState(() => _c1 = v!)),
                _buildCheckRow('Valid PAN card', _c2, (v) => setState(() => _c2 = v!)),
                _buildCheckRow('Property ownership / lease agreement', _c3, (v) => setState(() => _c3 = v!)),
                _buildCheckRow('Real photos of property and facilities', _c4, (v) => setState(() => _c4 = v!)),

                const SizedBox(height: 24),

                // 2 Action Buttons (Reject / Approve)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFEC1F27), width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          AppFeedback.showInfo(context, 'Verification request rejected.');
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Reject',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFEC1F27),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16A34A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          AppFeedback.showSuccess(context, 'Business Verified Successfully!');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminVerificationStatusScreen(businessName: widget.businessName),
                            ),
                          );
                        },
                        child: Text(
                          'Approve',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // Additional Info View
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Insurance Policy:', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text('Himalayan General Insurance Policy #88219 (Valid till 2028)', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 12),
                      Text('Trek Leader Certificates:', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text('TAAN Certified Senior Guides assigned to route.', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocItem(String title, String linkText, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0552A2).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.description_outlined, color: Color(0xFF0552A2), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  linkText,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0552A2),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 18),
        ],
      ),
    );
  }

  Widget _buildCheckRow(String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            activeColor: const Color(0xFF16A34A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              color: const Color(0xFF16A34A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
