import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/widgets/designSystem.dart';

class EditListingsScreen extends StatefulWidget {
  const EditListingsScreen({super.key});

  @override
  State<EditListingsScreen> createState() => _EditListingsScreenState();
}

class _EditListingsScreenState extends State<EditListingsScreen> {
  final List<Map<String, dynamic>> _listings = [
    {
      'title': 'Himalayan Escape Lodge',
      'type': 'Hotel & Resort',
      'location': 'Kathmandu, Nepal',
      'rate': '\$150 / night',
      'active': true,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Everest Base Camp Trek',
      'type': 'Trekking Route',
      'location': 'Solukhumbu, Nepal',
      'rate': '\$1,200 / person',
      'active': true,
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Pokhara Sightseeing & Lake Tour',
      'type': 'Place to Visit',
      'location': 'Pokhara, Nepal',
      'rate': '\$80 / person',
      'active': true,
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=400&q=80',
    },
    {
      'title': 'Pasang Sherpa Guide Service',
      'type': 'Mountain Guide',
      'location': 'Sagarmatha, Nepal',
      'rate': '\$120 / day',
      'active': true,
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
    },
  ];

  void _showEditItemDialog(Map<String, dynamic> item) {
    final titleCtrl = TextEditingController(text: item['title']);
    final rateCtrl = TextEditingController(text: item['rate']);
    final locCtrl = TextEditingController(text: item['location']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          'Edit Listing Details',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title / Place Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locCtrl,
              decoration: const InputDecoration(labelText: 'Location / Region'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: rateCtrl,
              decoration: const InputDecoration(labelText: 'Rate / Price'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0552A2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              setState(() {
                item['title'] = titleCtrl.text.trim();
                item['location'] = locCtrl.text.trim();
                item['rate'] = rateCtrl.text.trim();
              });
              Navigator.pop(ctx);
              AppFeedback.showSuccess(context, 'Listing updated!');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddListingDialog() {
    final titleCtrl = TextEditingController();
    final rateCtrl = TextEditingController();
    final locCtrl = TextEditingController();
    String typeVal = 'Hotel & Resort';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Text(
            'Add New Listing / Guide',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Place / Service Name', hintText: 'Annapurna Eco Lodge'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: typeVal,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: ['Hotel & Resort', 'Trekking Route', 'Place to Visit', 'Mountain Guide']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setDlgState(() => typeVal = v!),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: locCtrl,
                  decoration: const InputDecoration(labelText: 'Location', hintText: 'Pokhara, Nepal'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: rateCtrl,
                  decoration: const InputDecoration(labelText: 'Price / Rate', hintText: '\$120 / night'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (titleCtrl.text.trim().isEmpty) return;
                setState(() {
                  _listings.add({
                    'title': titleCtrl.text.trim(),
                    'type': typeVal,
                    'location': locCtrl.text.trim().isEmpty ? 'Nepal' : locCtrl.text.trim(),
                    'rate': rateCtrl.text.trim().isEmpty ? '\$100 / night' : rateCtrl.text.trim(),
                    'active': true,
                    'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=400&q=80',
                  });
                });
                Navigator.pop(ctx);
                AppFeedback.showSuccess(context, 'New listing published successfully!');
              },
              child: const Text('Add Listing'),
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

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFFAFBFD),
      appBar: AppBar(
        title: Text(
          'Manage & Edit Listings',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, fontSize: 15.5),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF16A34A), size: 24),
            onPressed: _showAddListingDialog,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Places to Visit, Hotels & Guide Services',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Update details, toggle active status, or add new Himalayan experiences.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: isDark ? Colors.white54 : const Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 14),

              ..._listings.map((item) {
                final bool isActive = item['active'] == true;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item['image'],
                          width: 58,
                          height: 58,
                          fit: BoxFit.cover,
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
                                    item['title'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: isActive,
                                  activeThumbColor: const Color(0xFF16A34A),
                                  onChanged: (val) {
                                    setState(() {
                                      item['active'] = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${item['type']} • ${item['location']}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10.5,
                                color: isDark ? Colors.white54 : const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['rate'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF0552A2),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _showEditItemDialog(item),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0552A2).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.edit_outlined, size: 12, color: Color(0xFF0552A2)),
                                        const SizedBox(width: 3),
                                        Text(
                                          'Edit',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0552A2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 16),

              AppButton(
                text: '+ Add New Place / Guide Listing',
                onPressed: _showAddListingDialog,
                width: double.infinity,
                height: 48,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
