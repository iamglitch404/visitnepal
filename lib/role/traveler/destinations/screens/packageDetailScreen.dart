import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class PackageDetailScreen extends StatefulWidget {
  final Map<String, dynamic> package;

  const PackageDetailScreen({super.key, required this.package});

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  bool _isWishlisted = false;
  int _selectedDay = 1;

  void _showBookingModal() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final price = widget.package['price'] ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Confirm Trekking Reservation',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              widget.package['title'] ?? '',
              style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Package Price', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    '\$$price USD',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Includes:'),
            const SizedBox(height: 6),
            Text(
              '• Licensed IFMGA Mountain Guide & Porter\n• All Teahouse / Lodge Accommodation\n• All Meals (Breakfast, Lunch, Dinner on trek)\n• Sagarmatha / Annapurna Trekking Permits & TIMS Card\n• Emergency Medical Oxygen & First Aid Kits',
              style: TextStyle(fontSize: 12, height: 1.5, color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'Confirm & Generate Boarding Pass',
              width: double.infinity,
              onPressed: () {
                Navigator.pop(context);
                final newBkg = {
                  'id': 'BKG-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                  'title': widget.package['title'],
                  'provider': 'Himalayan Sherpa Expeditions',
                  'category': 'Trek',
                  'date': 'Upcoming Expedition',
                  'status': 'Confirmed',
                  'amount': '\$$price',
                  'qrCode': 'CONFIRMED-${widget.package['id']}',
                  'color': theme.colorScheme.primary,
                  'icon': Icons.hiking_rounded,
                  'meetingPoint': 'Kathmandu Airport Hotel',
                  'assignedGuide': 'Pasang Nuru Sherpa',
                  'contactPhone': '+977 9841234567',
                };
                MockData.userBookings.insert(0, newBkg);
                AppFeedback.showSuccess(context, 'Trek reserved! Check your Bookings tab for your boarding pass.');
              },
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
    final pkg = widget.package;

    final List<String> highlights = List<String>.from(pkg['highlights'] ?? []);
    final List<Map<String, dynamic>> itinerary = List<Map<String, dynamic>>.from(pkg['itinerary'] ?? []);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    pkg['imageUrl'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade900),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pkg['category'] ?? 'Trek',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          pkg['title'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: _isWishlisted ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() => _isWishlisted = !_isWishlisted);
                  AppFeedback.showInfo(context, _isWishlisted ? 'Added to Saved Wishlist' : 'Removed from Wishlist');
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_rounded, color: Colors.white),
                onPressed: () {
                  AppFeedback.showInfo(context, 'Package link copied!');
                },
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildKeyStat(Icons.schedule_rounded, pkg['duration'] ?? '', 'Duration', theme),
                      _buildKeyStat(Icons.terrain_rounded, pkg['altitude'] ?? '', 'Max Altitude', theme),
                      _buildKeyStat(Icons.fitness_center_rounded, pkg['difficulty'] ?? '', 'Difficulty', theme),
                      _buildKeyStat(Icons.star_rounded, '${pkg['rating'] ?? 5.0}', 'Rating', theme),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(
                    pkg['description'] ?? '',
                    style: TextStyle(fontSize: 14, height: 1.5, color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
                  ),

                  if (highlights.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text('Expedition Highlights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    ...highlights.map((h) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle_rounded, size: 18, color: theme.colorScheme.primary),
                              const SizedBox(width: 10),
                              Expanded(child: Text(h, style: const TextStyle(fontSize: 13, height: 1.4))),
                            ],
                          ),
                        )),
                  ],

                  if (itinerary.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text('Daily Route & Altitude Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    ...itinerary.map((day) {
                      final dNum = day['day'] ?? 1;
                      final isSelected = _selectedDay == dNum;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDay = dNum),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected ? theme.colorScheme.primary : (isDark ? Colors.white10 : Colors.black12),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary.withValues(alpha: 0.12),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            'Day $dNum',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            day['title'] ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    day['altitude'] ?? '',
                                    style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                  ),
                                ],
                              ),
                              if (isSelected) ...[
                                const SizedBox(height: 8),
                                Text(
                                  day['desc'] ?? '',
                                  style: TextStyle(fontSize: 13, height: 1.4, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                  ],

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(top: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.08))),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price per person', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    '\$${pkg['price'] ?? 0}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppButton(
                  text: 'Book Expedition',
                  onPressed: _showBookingModal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyStat(IconData icon, String value, String label, ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
      ],
    );
  }
}
