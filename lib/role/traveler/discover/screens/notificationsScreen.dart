import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<Map<String, dynamic>> _items;
  String _selectedCategory = 'All';

  final List<String> _categories = const ['All', 'Trek Alerts', 'Bookings', 'Promos'];

  @override
  void initState() {
    super.initState();
    _items = List<Map<String, dynamic>>.from(MockData.notifications);
  }

  void _markAllAsRead() {
    setState(() {
      for (var item in _items) {
        item['read'] = true;
      }
    });
    AppFeedback.showSuccess(context, 'All notifications marked as read');
  }

  void _clearAll() {
    setState(() {
      _items.clear();
    });
    AppFeedback.showInfo(context, 'Notification inbox cleared');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filtered = _items.where((item) {
      if (_selectedCategory == 'All') return true;
      final category = (item['type'] ?? 'Trek Alerts').toString();
      return category.toLowerCase() == _selectedCategory.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15.5),
        ),
        centerTitle: false,
        actions: [
          if (_items.isNotEmpty) ...[
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                'Mark read',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0552A2),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, size: 20),
              onPressed: _clearAll,
            ),
          ],
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Category Filter Pills
            if (_items.isNotEmpty)
              SizedBox(
                height: 34,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final bool isSelected = cat == _selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0552A2)
                              : (isDark ? const Color(0xFF1E293B) : Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0552A2)
                                : (isDark ? Colors.white12 : const Color(0xFFE2E8F0)),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          cat,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF475569)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 12),

            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 48,
                            color: isDark ? Colors.white30 : const Color(0xFFCBD5E1),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No Notifications Found',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white70 : const Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You are all caught up with alerts, bookings, and updates.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 0, height: 10),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        final bool isRead = item['read'] ?? false;
                        final Color color = item['color'] as Color? ?? const Color(0xFF0552A2);

                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isRead
                                ? (isDark ? const Color(0xFF1E293B) : Colors.white)
                                : (isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF)),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isRead
                                  ? (isDark ? Colors.white10 : const Color(0xFFE2E8F0))
                                  : color.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  item['icon'] as IconData? ?? Icons.notifications_active_rounded,
                                  color: color,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item['title'] ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: isRead ? FontWeight.w700 : FontWeight.w800,
                                              fontSize: 13,
                                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          item['time'] ?? '',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 10,
                                            color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      item['body'] ?? '',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11.5,
                                        height: 1.35,
                                        color: isDark ? Colors.white70 : const Color(0xFF475569),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isRead) ...[
                                const SizedBox(width: 8),
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
