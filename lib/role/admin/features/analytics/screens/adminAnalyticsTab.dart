import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAnalyticsTab extends StatefulWidget {
  const AdminAnalyticsTab({super.key});

  @override
  State<AdminAnalyticsTab> createState() => _AdminAnalyticsTabState();
}

class _AdminAnalyticsTabState extends State<AdminAnalyticsTab> {
  String _selectedPeriod = 'Last 30 days';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Analytics & Reports',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isDark ? Colors.white12 : const Color(0xFFCBD5E1)),
            ),
            child: DropdownButton<String>(
              value: _selectedPeriod,
              underline: const SizedBox(),
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
              items: ['Last 7 days', 'Last 30 days', 'This Year']
                  .map((p) => DropdownMenuItem(value: p, child: Text(p, style: GoogleFonts.plusJakartaSans(fontSize: 10.5, fontWeight: FontWeight.w600))))
                  .toList(),
              onChanged: (v) => setState(() => _selectedPeriod = v!),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3 Stat Cards
              Row(
                children: [
                  _buildStatBox('Total Businesses', '2,842', '↗ 12%', const Color(0xFF16A34A), isDark),
                  const SizedBox(width: 8),
                  _buildStatBox('Verified', '2,361', '83%', const Color(0xFF2563EB), isDark),
                  const SizedBox(width: 8),
                  _buildStatBox('Pending', '421', '14.8%', const Color(0xFFD97706), isDark),
                ],
              ),

              const SizedBox(height: 18),

              // Verification Trends Chart Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Verification Trends',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        Row(
                          children: [
                            _buildLegendDot(const Color(0xFF16A34A), 'Verified'),
                            const SizedBox(width: 10),
                            _buildLegendDot(const Color(0xFFFDB716), 'Pending'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _TrendsChartPainter(isDark: isDark),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['Oct 1', 'Oct 7', 'Oct 14', 'Oct 21', 'Oct 28'].map((d) {
                        return Text(d, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey));
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Top Business Categories Breakdown Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Business Categories',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildCategoryRow('Hotels', '48%', const Color(0xFF0552A2), isDark),
                    _buildCategoryRow('Trekking', '23%', const Color(0xFF16A34A), isDark),
                    _buildCategoryRow('Activities', '16%', const Color(0xFFFDB716), isDark),
                    _buildCategoryRow('Transport', '8%', const Color(0xFF9333EA), isDark),
                    _buildCategoryRow('Others', '5%', const Color(0xFFEC1F27), isDark),
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

  Widget _buildStatBox(String title, String val, String sub, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 9.5, color: Colors.grey)),
            const SizedBox(height: 2),
            Text(val, style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w900, color: isDark ? Colors.white : const Color(0xFF0F172A))),
            Text(sub, style: GoogleFonts.plusJakartaSans(fontSize: 9.5, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(Color c, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCategoryRow(String title, String pct, Color color, bool isDark) {
    final double fraction = double.parse(pct.replaceAll('%', '')) / 100.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 11.5, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : const Color(0xFF334155))),
              Text(pct, style: GoogleFonts.plusJakartaSans(fontSize: 11.5, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 3),
          LinearProgressIndicator(
            value: fraction,
            backgroundColor: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 5,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}

class _TrendsChartPainter extends CustomPainter {
  final bool isDark;

  _TrendsChartPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = isDark ? Colors.white10 : const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    for (double y = 0; y <= size.height; y += size.height / 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final greenPoints = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.25, size.height * 0.65),
      Offset(size.width * 0.50, size.height * 0.5),
      Offset(size.width * 0.75, size.height * 0.35),
      Offset(size.width, size.height * 0.2),
    ];

    final yellowPoints = [
      Offset(0, size.height * 0.9),
      Offset(size.width * 0.25, size.height * 0.8),
      Offset(size.width * 0.50, size.height * 0.75),
      Offset(size.width * 0.75, size.height * 0.65),
      Offset(size.width, size.height * 0.55),
    ];

    final greenPaint = Paint()..color = const Color(0xFF16A34A)..strokeWidth = 2.0..style = PaintingStyle.stroke;
    final yellowPaint = Paint()..color = const Color(0xFFFDB716)..strokeWidth = 2.0..style = PaintingStyle.stroke;

    final p1 = Path()..moveTo(greenPoints[0].dx, greenPoints[0].dy);
    for (int i = 1; i < greenPoints.length; i++) {
      p1.lineTo(greenPoints[i].dx, greenPoints[i].dy);
    }
    canvas.drawPath(p1, greenPaint);

    final p2 = Path()..moveTo(yellowPoints[0].dx, yellowPoints[0].dy);
    for (int i = 1; i < yellowPoints.length; i++) {
      p2.lineTo(yellowPoints[i].dx, yellowPoints[i].dy);
    }
    canvas.drawPath(p2, yellowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
