import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessHomeBanner extends StatelessWidget {
  final String companyName;
  final String subtitle;
  final String bannerImageUrl;

  const BusinessHomeBanner({
    super.key,
    required this.companyName,
    required this.subtitle,
    required this.bannerImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(bannerImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.35),
              Colors.black.withValues(alpha: 0.75),
            ],
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Good Morning,',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    companyName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF4ADE80),
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10.5,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
