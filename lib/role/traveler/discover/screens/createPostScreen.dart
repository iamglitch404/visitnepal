import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class CreatePostScreen extends StatefulWidget {
  final Function(Map<String, dynamic>)? onPostCreated;

  const CreatePostScreen({super.key, this.onPostCreated});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController(text: 'Kathmandu, Nepal');
  String? _selectedImageUrl = 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=900&q=80';
  bool _isSubmitting = false;

  final List<String> _sampleImages = [
    'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1570789210967-2cac24afeb00?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=900&q=80',
  ];

  void _submit() {
    final text = _contentController.text.trim();
    if (text.isEmpty) {
      AppFeedback.showInfo(context, 'Please share your experience');
      return;
    }

    setState(() => _isSubmitting = true);

    final newPost = {
      'id': 'post_${DateTime.now().millisecondsSinceEpoch}',
      'authorName': MockData.currentUser['name'],
      'authorAvatar': MockData.currentUser['avatar'],
      'authorLocation': _locationController.text.trim(),
      'timeAgo': 'Just now',
      'verified': true,
      'content': text,
      'mediaUrl': _selectedImageUrl,
      'likesCount': 1,
      'userReaction': 'love',
      'commentsCount': 0,
      'comments': [],
    };

    MockData.communityPosts.insert(0, newPost);
    if (widget.onPostCreated != null) {
      widget.onPostCreated!(newPost);
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.pop(context);
        AppFeedback.showSuccess(context, 'Your story is published to the community!');
      }
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = MockData.currentUser;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Create Story', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: AppButton(
              text: 'Publish',
              height: 36,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(user['avatar']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: theme.colorScheme.primary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: TextField(
                              controller: _locationController,
                              style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
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
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 5,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: 'Share your Himalayan journey, trail tips, or mountain reflections...',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Attach Photo', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 10),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _sampleImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final img = _sampleImages[index];
                  final isSelected = _selectedImageUrl == img;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedImageUrl = img),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.network(img, fit: BoxFit.cover),
                      ),
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
