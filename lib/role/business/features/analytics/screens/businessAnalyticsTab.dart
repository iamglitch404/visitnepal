import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessAnalyticsTab extends StatefulWidget {
  const BusinessAnalyticsTab({super.key});

  @override
  State<BusinessAnalyticsTab> createState() => _BusinessAnalyticsTabState();
}

class _BusinessAnalyticsTabState extends State<BusinessAnalyticsTab> {
  String _selectedPeriod = 'Last 30 days';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analytics',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Track your performance and grow faster.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          color: isDark ? Colors.white54 : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.white12 : const Color(0xFFCBD5E1),
                        width: 1,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedPeriod,
                      underline: const SizedBox(),
                      isDense: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
                      items: ['Last 7 days', 'Last 30 days', 'This Year']
                          .map((p) => DropdownMenuItem(value: p, child: Text(p, style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w600))))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedPeriod = v!),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // 3 Stat Cards Row
              Row(
                children: [
                  _buildStatBox(
                    context,
                    title: 'Total Revenue',
                    value: '\$4,860',
                    trend: '↗ 8.4%',
                    icon: Icons.attach_money_rounded,
                    color: const Color(0xFF16A34A),
                    bgColor: const Color(0xFFDCFCE7),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 8),
                  _buildStatBox(
                    context,
                    title: 'Total Bookings',
                    value: '128',
                    trend: '↗ 12.8%',
                    icon: Icons.shopping_bag_outlined,
                    color: const Color(0xFF2563EB),
                    bgColor: const Color(0xFFEFF6FF),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 8),
                  _buildStatBox(
                    context,
                    title: 'Occupancy Rate',
                    value: '78%',
                    trend: '↗ 6.2%',
                    icon: Icons.pie_chart_outline_rounded,
                    color: const Color(0xFFEA580C),
                    bgColor: const Color(0xFFFFEDD5),
                    isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Revenue Overview Chart Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Revenue Overview',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Custom Painted Line Chart Box
                    SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _RevenueChartPainter(isDark: isDark),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['Oct 1', 'Oct 7', 'Oct 14', 'Oct 21', 'Oct 28'].map((date) {
                        return Text(
                          date,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Top Performing Listings Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Performing Listings',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    'View all →',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0552A2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _buildTopListingItem(
                title: 'Himalayan Escape Lodge',
                revenue: '\$2,340',
                bookings: '48 bookings',
                badgeText: 'Top Seller',
                badgeColor: const Color(0xFFDCFCE7),
                textColor: const Color(0xFF16A34A),
                image: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=200&q=80',
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              _buildTopListingItem(
                title: 'Everest Base Camp Trek',
                revenue: '\$1,200',
                bookings: '28 bookings',
                badgeText: '2nd',
                badgeColor: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                textColor: isDark ? Colors.white70 : const Color(0xFF64748B),
                image: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=200&q=80',
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              _buildTopListingItem(
                title: 'Pokhara Valley Resort',
                revenue: '\$1,140',
                bookings: '22 bookings',
                badgeText: '3rd',
                badgeColor: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                textColor: isDark ? Colors.white70 : const Color(0xFF64748B),
                image: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=200&q=80',
                isDark: isDark,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(
    BuildContext context, {
    required String title,
    required String value,
    required String trend,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 14),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: isDark ? Colors.white54 : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              trend,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF16A34A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopListingItem({
    required String title,
    required String revenue,
    required String bookings,
    required String badgeText,
    required Color badgeColor,
    required Color textColor,
    required String image,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image, width: 42, height: 42, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  '$revenue • $bookings',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5,
                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badgeText,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueChartPainter extends CustomPainter {
  final bool isDark;

  _RevenueChartPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = isDark ? Colors.white10 : const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    // Draw horizontal gridlines
    for (double y = 0; y <= size.height; y += size.height / 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = [
      Offset(0, size.height * 0.75),
      Offset(size.width * 0.25, size.height * 0.55),
      Offset(size.width * 0.50, size.height * 0.45),
      Offset(size.width * 0.75, size.height * 0.25),
      Offset(size.width, size.height * 0.10),
    ];

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = const Color(0xFF16A34A)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = const Color(0xFF16A34A);
    final innerDotPaint = Paint()..color = Colors.white;

    for (final p in points) {
      canvas.drawCircle(p, 4.5, dotPaint);
      canvas.drawCircle(p, 2.0, innerDotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
