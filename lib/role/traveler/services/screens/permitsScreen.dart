import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class PermitsScreen extends StatelessWidget {
  const PermitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Trekking Permits & TIMS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.permits.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final pmt = MockData.permits[index];

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        pmt['code'],
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                      ),
                    ),
                    AppStatusChip(status: pmt['status']),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  pmt['title'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  'Issuing Authority: ${pmt['authority']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cost: ${pmt['cost']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        pmt['approvalDate'] ?? '',
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                AppButton(
                  text: pmt['status'] == 'Approved' ? 'Download Digital Permit PDF' : 'Apply / Expedite',
                  variant: pmt['status'] == 'Approved' ? AppButtonVariant.outline : AppButtonVariant.primary,
                  width: double.infinity,
                  onPressed: () {
                    if (pmt['status'] == 'Approved') {
                      AppFeedback.showSuccess(context, 'Downloading authorized permit with QR validation');
                    } else {
                      AppFeedback.showInfo(context, 'Permit expedited with Nepal Tourism Board portal');
                    }
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
