import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Himalayan Adventures', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.activities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final act = MockData.activities[index];

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
                        act['imageUrl'],
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                              const SizedBox(width: 3),
                              Text('${act['rating']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
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
                              act['title'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Text(
                            act['price'],
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: theme.colorScheme.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                          const SizedBox(width: 4),
                          Text(act['location'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                          const SizedBox(width: 12),
                          Icon(Icons.schedule_rounded, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                          const SizedBox(width: 4),
                          Text(act['duration'], style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('Operator: ${act['operator']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),
                      AppButton(
                        text: 'Book Activity',
                        width: double.infinity,
                        onPressed: () {
                          AppFeedback.showSuccess(context, 'Activity booked! Confirmation voucher sent.');
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
