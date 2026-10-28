import 'package:flutter/material.dart';
import '../../../../core/data/mockData.dart';
import '../../../../core/widgets/designSystem.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map<String, dynamic>? _selectedConversation;
  final TextEditingController _msgCtrl = TextEditingController();

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty || _selectedConversation == null) return;

    final List<Map<String, dynamic>> messages = List<Map<String, dynamic>>.from(_selectedConversation!['messages'] ?? []);
    setState(() {
      messages.add({
        'id': 'm_${DateTime.now().millisecondsSinceEpoch}',
        'sender': 'Aayush',
        'text': text,
        'time': 'Just now',
        'isMe': true,
      });
      _selectedConversation!['messages'] = messages;
      _selectedConversation!['lastMessage'] = text;
      _msgCtrl.clear();
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted && _selectedConversation != null) {
        setState(() {
          messages.add({
            'id': 'm_${DateTime.now().millisecondsSinceEpoch}',
            'sender': _selectedConversation!['name'].split(' ').first,
            'text': 'Tashi Delek! Received your message. Will keep everything ready for our journey.',
            'time': 'Just now',
            'isMe': false,
          });
          _selectedConversation!['messages'] = messages;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_selectedConversation != null) {
      final conv = _selectedConversation!;
      final List<Map<String, dynamic>> messages = List<Map<String, dynamic>>.from(conv['messages'] ?? []);

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => setState(() => _selectedConversation = null),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(conv['avatar']),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(conv['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        Text(conv['status'] ?? 'Online', style: const TextStyle(fontSize: 11, color: Color(0xFF16A34A))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(icon: const Icon(Icons.phone_rounded), onPressed: () => AppFeedback.showInfo(context, 'Calling via secure VoIP...')),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final bool isMe = msg['isMe'] ?? false;

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(
                        color: isMe
                            ? theme.colorScheme.primary
                            : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isMe ? 16 : 4),
                          bottomRight: Radius.circular(isMe ? 4 : 16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg['text'] ?? '',
                            style: TextStyle(
                              color: isMe ? Colors.white : theme.colorScheme.onSurface,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg['time'] ?? '',
                            style: TextStyle(
                              fontSize: 10,
                              color: isMe ? Colors.white70 : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.black12)),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mic_rounded, color: Colors.grey),
                      onPressed: () => AppFeedback.showInfo(context, 'Audio note recorded'),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _msgCtrl,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                          isDense: true,
                          filled: true,
                          fillColor: isDark ? Colors.black12 : const Color(0xFFF1F5F9),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Direct Messages', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.conversations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final conv = MockData.conversations[index];

          return AppCard(
            onTap: () => setState(() => _selectedConversation = conv),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(conv['avatar']),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
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
                              conv['name'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            conv['lastTime'] ?? '',
                            style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        conv['lastMessage'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
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
