import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';
import '../../chat/screens/chatScreen.dart';
import '../widgets/bookingItemCard.dart';

class BookingsTab extends StatefulWidget {
  final VoidCallback? onNavigateToChat;
  final VoidCallback? onBack;

  const BookingsTab({super.key, this.onNavigateToChat, this.onBack});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  String _selectedStatus = 'Booked';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _tabs = ['Booked', 'Completed', 'Cancelled'];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showVoucherDialog(BuildContext context, Map<String, dynamic> booking) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color color = booking['color'] as Color? ?? theme.colorScheme.primary;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(booking['icon'] as IconData? ?? Icons.confirmation_number, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking['category'] ?? 'Expedition', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
                      Text(booking['id'] ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                AppStatusChip(status: booking['status'] ?? 'Confirmed'),
              ],
            ),

            const SizedBox(height: 16),
            Text(
              booking['title'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              'Provider: ${booking['provider']}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.qr_code_2_rounded, size: 140, color: Colors.black87),
                  const SizedBox(height: 6),
                  Text(
                    booking['qrCode'] ?? 'VERIFIED-BOOKING',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Meeting Location:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(booking['meetingPoint'] ?? 'Kathmandu Hotel', style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Assigned Guide:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(booking['assignedGuide'] ?? 'Pasang Nuru', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Contact Emergency:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(booking['contactPhone'] ?? '+977 9841234567', style: const TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Contact Guide',
                    variant: AppButtonVariant.outline,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    text: 'Done',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bookings = MockData.userBookings.where((b) {
      final status = (b['status'] as String? ?? '').toLowerCase();
      bool matchesTab = false;
      if (_selectedStatus == 'Booked') {
        matchesTab = status.contains('confirmed') || status.contains('booked');
      } else if (_selectedStatus == 'Completed') {
        matchesTab = status.contains('completed');
      } else {
        matchesTab = status.contains('cancel');
      }

      final query = _searchQuery.toLowerCase();
      final matchesQuery = query.isEmpty ||
          (b['title'] as String).toLowerCase().contains(query) ||
          (b['id'] as String).toLowerCase().contains(query);

      return matchesTab && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Bookings & Vouchers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.3),
              ),
              const SizedBox(height: 2),
              Text(
                'Access confirmed expeditions, teahouse check-in QR passes & receipts',
                style: TextStyle(fontSize: 11.5, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _searchCtrl,
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
                decoration: InputDecoration(
                  hintText: 'Search by booking code or title...',
                  hintStyle: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  filled: true,
                  fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: _tabs.map((tab) {
                  final isSelected = _selectedStatus == tab;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedStatus = tab),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              if (bookings.isEmpty)
                AppEmptyState(
                  title: 'No $_selectedStatus Bookings',
                  message: 'You have no $_selectedStatus bookings at this time.',
                )
              else
                ...bookings.map((b) => BookingItemCard(
                      booking: b,
                      onTap: () => _showVoucherDialog(context, b),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
