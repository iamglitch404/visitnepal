import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Certified Mountain Guides', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.guides.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final guide = MockData.guides[index];
          final List<String> languages = List<String>.from(guide['languages'] ?? []);

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(guide['avatar']),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  guide['name'],
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                guide['rate'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            guide['role'],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                              const SizedBox(width: 3),
                              Text(
                                '${guide['rating']} (${guide['reviews']} reviews)',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '•  ${guide['experience']}',
                                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  guide['bio'],
                  style: TextStyle(fontSize: 13, height: 1.4, color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.terrain_rounded, size: 16, color: Color(0xFF16A34A)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Summits: ${guide['summits']}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Languages: ',
                      style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                    ),
                    Text(
                      languages.join(', '),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Contact Guide',
                        variant: AppButtonVariant.outline,
                        onPressed: () {
                          AppFeedback.showInfo(context, 'Chat request sent to ${guide['name']}');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton(
                        text: 'Hire Guide',
                        onPressed: () {
                          AppFeedback.showSuccess(context, 'Booking request confirmed with ${guide['name']}');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
