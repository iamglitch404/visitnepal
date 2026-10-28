import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class ButlerScreen extends StatelessWidget {
  const ButlerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Sherpa Butler & Expedition Concierge', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.butlers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final butler = MockData.butlers[index];
          final List<String> skills = List<String>.from(butler['skills'] ?? []);

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundImage: NetworkImage(butler['avatar']),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(butler['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text(butler['rate'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: theme.colorScheme.primary)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(butler['role'], style: TextStyle(fontSize: 13, color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                              const SizedBox(width: 3),
                              Text('${butler['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(width: 8),
                              Text('•  ${butler['trips']}', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text('Specialized Services:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: skills.map((s) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(s, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                AppButton(
                  text: 'Request Butler Assignment',
                  width: double.infinity,
                  onPressed: () {
                    AppFeedback.showSuccess(context, 'Sherpa butler requested for your upcoming trek!');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
