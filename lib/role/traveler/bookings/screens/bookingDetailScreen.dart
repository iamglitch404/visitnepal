import 'package:flutter/material.dart';
import '../../../../core/widgets/designSystem.dart';
import '../../chat/screens/chatScreen.dart';

class BookingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingDetailScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color color = booking['color'] as Color? ?? theme.colorScheme.primary;
    final String bookedBy = booking['bookedBy'] as String? ?? 'Aayush Pradhan';

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Booking Details',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              size: 20,
              color: isDark ? Colors.white70 : const Color(0xFF64748B),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Voucher link copied to clipboard'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. QR Code Pass (At the very top)
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.qr_code_2_rounded,
                        size: 160,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      booking['qrCode'] ?? 'VERIFIED-BOOKING',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: isDark ? Colors.white70 : const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.verified_rounded, size: 15, color: Color(0xFF16A34A)),
                        SizedBox(width: 5),
                        Text(
                          'Scan at check-in or present to guide',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                ),
              ),

              // 2. Status & ID Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      booking['id'] ?? '',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: color,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  AppStatusChip(status: booking['status'] ?? 'Confirmed'),
                ],
              ),

              const SizedBox(height: 12),

              // 3. Title & Provider
              Text(
                booking['title'] ?? '',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.storefront_rounded,
                    size: 15,
                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Provided by ${booking['provider']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white60 : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                ),
              ),

              // 4. Booking Summary (Flat, minimal, no card boxes)
              Text(
                'BOOKING SUMMARY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDetailTile(
                      icon: Icons.calendar_today_rounded,
                      label: 'Booked Date',
                      value: booking['date'] ?? '',
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDetailTile(
                      icon: Icons.person_outline_rounded,
                      label: 'Booked By',
                      value: bookedBy,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDetailTile(
                      icon: Icons.payments_outlined,
                      label: 'Total Amount',
                      value: '${booking['amount'] ?? ''} (Verified)',
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDetailTile(
                      icon: Icons.confirmation_number_outlined,
                      label: 'Category',
                      value: booking['category'] ?? 'Expedition',
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                ),
              ),

              // 5. Logistics & Coordination (Flat, minimal, no card boxes)
              Text(
                'LOGISTICS & GUIDE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 14),

              _buildInfoRow(
                icon: Icons.location_on_rounded,
                iconColor: const Color(0xFFEF4444),
                title: 'Meeting Location',
                subtitle: booking['meetingPoint'] ?? 'Kathmandu Hotel Lobby',
                isDark: isDark,
              ),
              const SizedBox(height: 14),
              _buildInfoRow(
                icon: Icons.badge_rounded,
                iconColor: const Color(0xFF2563EB),
                title: 'Assigned Guide / Coordinator',
                subtitle: '${booking['assignedGuide'] ?? 'Pasang Nuru'} (Certified Guide)',
                isDark: isDark,
              ),
              const SizedBox(height: 14),
              _buildInfoRow(
                icon: Icons.phone_in_talk_rounded,
                iconColor: const Color(0xFF16A34A),
                title: 'Emergency Contact Phone',
                subtitle: booking['contactPhone'] ?? '+977 9841234567',
                isDark: isDark,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                ),
              ),

              // 6. Action Buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Contact Guide',
                      icon: Icons.chat_bubble_outline_rounded,
                      variant: AppButtonVariant.outline,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ChatScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: 'Done',
                      icon: Icons.check_circle_outline_rounded,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white54 : const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
