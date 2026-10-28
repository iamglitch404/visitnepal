import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';
import 'adminReviewApproveScreen.dart';

class AdminBusinessDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? business;

  const AdminBusinessDetailsScreen({
    super.key,
    this.business,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String name = business?['title'] ?? 'Himalayan Escape Lodge';

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Business Details',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Banner
              Stack(
                children: [
                  Image.network(
                    business?['image'] ?? 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1000&q=80',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '1/5 Photos',
                        style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const Icon(Icons.verified_rounded, color: Color(0xFF2563EB), size: 18),
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
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, size: 13, color: Color(0xFF2563EB)),
                        const SizedBox(width: 3),
                        Text(
                          'Kathmandu, Bagmati Province',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            color: isDark ? Colors.white60 : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(Icons.phone_outlined, size: 13, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text('+977 9812345678', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: isDark ? Colors.white70 : const Color(0xFF475569))),
                        const SizedBox(width: 14),
                        const Icon(Icons.email_outlined, size: 13, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text('info@himalayanescape.com', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: isDark ? Colors.white70 : const Color(0xFF475569))),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Basic Information Table Card
                    Text(
                      'Basic Information',
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
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow('Business Name', name, isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('Category', 'Hotel & Resort', isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('Location', 'Kathmandu, Bagmati Province', isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('Contact Number', '+977 9812345678', isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('Email', 'info@himalayanescape.com', isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('Website', 'www.himalayanescape.com', isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('Owner Name', 'Ramesh Shrestha', isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('Registration No.', '123456/2078', isDark),
                          _buildDivider(isDark),
                          _buildDetailRow('PAN No.', '609875432', isDark),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    AppButton(
                      text: 'Proceed to Review & Audit →',
                      width: double.infinity,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminReviewApproveScreen(businessName: name),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: isDark ? Colors.white54 : const Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 14,
      endIndent: 14,
      color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F5F9),
    );
  }
}
