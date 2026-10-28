import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Stays & Mountain Lodges', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.hotels.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final hotel = MockData.hotels[index];
          final List<String> highlights = List<String>.from(hotel['highlights'] ?? []);

          return AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Image.network(
                        hotel['imageUrl'],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${hotel['rating']}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              hotel['name'],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Text(
                            hotel['price'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                          const SizedBox(width: 4),
                          Text(
                            hotel['location'],
                            style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        hotel['description'],
                        style: TextStyle(fontSize: 13, height: 1.4, color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: highlights.map((h) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(h, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        )).toList(),
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        text: 'Reserve Stay',
                        width: double.infinity,
                        onPressed: () {
                          AppFeedback.showSuccess(context, 'Reservation inquiry sent to ${hotel['name']}');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
