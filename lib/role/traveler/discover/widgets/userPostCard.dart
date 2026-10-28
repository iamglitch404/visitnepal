import 'package:flutter/material.dart';

enum ReactionType { none, like, love, haha, wow, sad, angry }

extension ReactionExtension on ReactionType {
  String get emoji {
    switch (this) {
      case ReactionType.none:
        return '👍';
      case ReactionType.like:
        return '👍';
      case ReactionType.love:
        return '❤️';
      case ReactionType.haha:
        return '😂';
      case ReactionType.wow:
        return '😮';
      case ReactionType.sad:
        return '😢';
      case ReactionType.angry:
        return '😡';
    }
  }

  Color get color {
    switch (this) {
      case ReactionType.none:
        return Colors.grey;
      case ReactionType.like:
        return Colors.blue;
      case ReactionType.love:
        return Colors.red;
      case ReactionType.haha:
        return Colors.amber.shade700;
      case ReactionType.wow:
        return Colors.amber.shade700;
      case ReactionType.sad:
        return Colors.amber.shade700;
      case ReactionType.angry:
        return Colors.deepOrange;
    }
  }

  String get label {
    switch (this) {
      case ReactionType.none:
        return 'Like';
      case ReactionType.like:
        return 'Like';
      case ReactionType.love:
        return 'Love';
      case ReactionType.haha:
        return 'Haha';
      case ReactionType.wow:
        return 'Wow';
      case ReactionType.sad:
        return 'Sad';
      case ReactionType.angry:
        return 'Angry';
    }
  }
}

class UserPostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  final VoidCallback? onProfileTap;

  const UserPostCard({
    super.key,
    required this.post,
    this.onProfileTap,
  });

  @override
  State<UserPostCard> createState() => _UserPostCardState();
}

class _UserPostCardState extends State<UserPostCard> {
  late ReactionType _reaction;
  late int _likesCount;
  bool _showComments = false;
  final TextEditingController _commentController = TextEditingController();
  late List<Map<String, dynamic>> _comments;

  @override
  void initState() {
    super.initState();
    final rStr = widget.post['userReaction'] as String?;
    _reaction = _parseReaction(rStr);
    _likesCount = widget.post['likesCount'] ?? 0;
    _comments = List<Map<String, dynamic>>.from(widget.post['comments'] ?? []);
  }

  ReactionType _parseReaction(String? str) {
    switch (str?.toLowerCase()) {
      case 'like':
        return ReactionType.like;
      case 'love':
        return ReactionType.love;
      case 'haha':
        return ReactionType.haha;
      case 'wow':
        return ReactionType.wow;
      case 'sad':
        return ReactionType.sad;
      case 'angry':
        return ReactionType.angry;
      default:
        return ReactionType.none;
    }
  }

  void _selectReaction(ReactionType type) {
    setState(() {
      if (_reaction == type) {
        _reaction = ReactionType.none;
        _likesCount = (_likesCount - 1).clamp(0, 999999);
      } else {
        if (_reaction == ReactionType.none) {
          _likesCount++;
        }
        _reaction = type;
      }
    });
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'author': 'Aayush Pradhan',
        'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
        'text': text,
        'timeAgo': 'Just now',
        'likes': 0,
      });
      _commentController.clear();
      _showComments = true;
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String authorName = widget.post['authorName'] ?? 'Traveler';
    final String authorAvatar = widget.post['authorAvatar'] ?? '';
    final String authorLocation = widget.post['authorLocation'] ?? 'Nepal';
    final String timeAgo = widget.post['timeAgo'] ?? '';
    final bool verified = widget.post['verified'] ?? false;
    final String content = widget.post['content'] ?? '';
    final String? mediaUrl = widget.post['mediaUrl'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.06),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onProfileTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(authorAvatar),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              authorName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ),
                          if (verified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified_rounded, size: 15, color: Color(0xFF2563EB)),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 11,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              '$authorLocation • $timeAgo',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz_rounded, size: 20),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
              child: Text(
                content,
                style: const TextStyle(fontSize: 14, height: 1.45),
              ),
            ),

          const SizedBox(height: 8),

          if (mediaUrl != null && mediaUrl.isNotEmpty)
            ClipRRect(
              child: Image.network(
                mediaUrl,
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey.shade800,
                  child: const Center(child: Icon(Icons.image_not_supported, color: Colors.white54)),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.thumb_up_rounded, size: 10, color: Colors.white),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_rounded, size: 10, color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$_likesCount',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => setState(() => _showComments = !_showComments),
                  child: Text(
                    '${_comments.length} comments',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Row(
              children: [
                Expanded(
                  child: PopupMenuButton<ReactionType>(
                    tooltip: 'Choose reaction',
                    offset: const Offset(0, -50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        enabled: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _reactionChoice(ReactionType.like),
                            _reactionChoice(ReactionType.love),
                            _reactionChoice(ReactionType.haha),
                            _reactionChoice(ReactionType.wow),
                            _reactionChoice(ReactionType.sad),
                            _reactionChoice(ReactionType.angry),
                          ],
                        ),
                      ),
                    ],
                    child: InkWell(
                      onTap: () => _selectReaction(_reaction == ReactionType.none ? ReactionType.like : _reaction),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _reaction == ReactionType.none ? '👍' : _reaction.emoji,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _reaction == ReactionType.none ? 'Like' : _reaction.label,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: _reaction == ReactionType.none ? theme.colorScheme.onSurface.withValues(alpha: 0.7) : _reaction.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _showComments = !_showComments),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded, size: 18, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                          const SizedBox(width: 6),
                          Text(
                            'Comment',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Story link copied to clipboard!'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share_outlined, size: 18, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                          const SizedBox(width: 6),
                          Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (_showComments) ...[
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.all(12.0),
              color: isDark ? Colors.black.withValues(alpha: 0.15) : const Color(0xFFF8FAFC),
              child: Column(
                children: [
                  ..._comments.map((c) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage(c['avatar']),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          c['author'],
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                        ),
                                        Text(
                                          c['timeAgo'],
                                          style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(c['text'], style: const TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            hintStyle: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                            isDense: true,
                            filled: true,
                            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
                            ),
                          ),
                          onSubmitted: (_) => _addComment(),
                        ),
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        icon: Icon(Icons.send_rounded, size: 20, color: theme.colorScheme.primary),
                        onPressed: _addComment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _reactionChoice(ReactionType type) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _selectReaction(type);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Text(
          type.emoji,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
