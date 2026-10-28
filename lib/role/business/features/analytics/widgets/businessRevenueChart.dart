import 'package:flutter/material.dart';

class BusinessRevenueChart extends StatelessWidget {
  final bool isDark;

  const BusinessRevenueChart({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: CustomPaint(
        painter: _RevenueChartPainter(isDark: isDark),
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
