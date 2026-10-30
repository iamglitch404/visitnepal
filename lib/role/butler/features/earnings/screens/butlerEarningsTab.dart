import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class ButlerEarningsTab extends StatelessWidget {
  const ButlerEarningsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, String>> ledger = const [
      {'title': 'VIP Butler Hospitality Fee (10 Days)', 'date': 'Oct 28, 2026', 'amount': '+\$950.00 USD'},
      {'title': 'Traveler Gratuity Tip (Aarav Sharma)', 'date': 'Oct 26, 2026', 'amount': '+\$350.00 USD'},
      {'title': 'High-Altitude Teahouse Butler Fee (12 Days)', 'date': 'Oct 18, 2026', 'amount': '+\$1,140.00 USD'},
      {'title': 'Bank Payout to Himalayan Bank Ltd', 'date': 'Oct 15, 2026', 'amount': '-\$1,000.00 USD'},
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Butler Earnings & Gratuities',
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
              // Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9333EA), Color(0xFF0552A2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9333EA).withValues(alpha: 0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available Payout Balance', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.white70)),
                    const SizedBox(height: 4),
                    Text('\$2,400.00 USD', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.verified_rounded, color: Color(0xFF4ADE80), size: 14),
                        const SizedBox(width: 4),
                        Text('Base Rate: \$95 / day • Daily Payouts & Tips', style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              AppButton(
                text: 'Request Instant Bank Payout',
                width: double.infinity,
                onPressed: () {
                  AppFeedback.showSuccess(context, 'Payout request of \$2,400 USD submitted to Himalayan Bank Ltd');
                },
              ),

              const SizedBox(height: 20),

              Text(
                'Recent Earnings & Gratuity Ledger',
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
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: ledger.map((item) {
                    final isDebit = item['amount']!.startsWith('-');
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                          dense: true,
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDebit
                                  ? const Color(0xFFEC1F27).withValues(alpha: 0.12)
                                  : const Color(0xFF16A34A).withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isDebit ? Icons.account_balance_rounded : Icons.payments_rounded,
                              color: isDebit ? const Color(0xFFEC1F27) : const Color(0xFF16A34A),
                              size: 18,
                            ),
                          ),
                          title: Text(
                            item['title']!,
                            style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                          ),
                          subtitle: Text(item['date']!, style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: isDark ? Colors.white54 : const Color(0xFF64748B))),
                          trailing: Text(
                            item['amount']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isDebit ? const Color(0xFFEC1F27) : const Color(0xFF16A34A),
                            ),
                          ),
                        ),
                        if (ledger.indexOf(item) != ledger.length - 1)
                          Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF1F5F9)),
                      ],
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
