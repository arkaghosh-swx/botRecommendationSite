// /home/solworxs11/Public/botRecommendationSite/Swx Bot/lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../core/constants/app_constants.dart';
import '../features/chat/models/chat_message.dart';
import '../features/chat/services/groq_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final List<Map<String, String>> _apiHistory = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isTyping = false;

  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();

    // Initial greeting
    _addBotMessage(AppConstants.initialGreeting);
  }

  // ── Send Message ───────────────────────────────
  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();

    _addUserMessage(text);

    setState(() => _isTyping = true);

    // Add to API history
    _apiHistory.add({'role': 'user', 'content': text});

    // ── Call AI ───────────────────────────────
    final reply = await GroqService.chat(
      userMessage: text,
      history: _getTrimmedHistory(),
      faqContext: '', // we'll connect Supabase later
    );

    setState(() => _isTyping = false);

    _addBotMessage(reply);

    _apiHistory.add({'role': 'assistant', 'content': reply});
  }

  List<Map<String, String>> _getTrimmedHistory() {
    if (_apiHistory.length <= AppConstants.maxHistoryLength) {
      return _apiHistory;
    }
    return _apiHistory.sublist(
      _apiHistory.length - AppConstants.maxHistoryLength,
    );
  }

  // ── Message Helpers ───────────────────────────
  void _addUserMessage(String text) {
    final msg = ChatMessage(
      id: uuid.v4(),
      role: MessageRole.user,
      text: text,
      time: DateTime.now(),
    );

    setState(() => _messages.add(msg));
    _scrollToBottom();
  }

  void _addBotMessage(String text) {
    final msg = ChatMessage(
      id: uuid.v4(),
      role: MessageRole.bot,
      text: text,
      time: DateTime.now(),
    );

    setState(() => _messages.add(msg));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ── UI ────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppConstants.botName)),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return _typingIndicator();
                }

                final msg = _messages[index];
                return _messageBubble(msg);
              },
            ),
          ),

          // Input
          _inputArea(),
        ],
      ),
    );
  }

  // ── Message Bubble ────────────────────────────
  Widget _messageBubble(ChatMessage msg) {
    final isUser = msg.role == MessageRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          msg.text,
          style: TextStyle(color: isUser ? Colors.white : Colors.white70),
        ),
      ),
    );
  }

  // ── Typing Indicator ──────────────────────────
  Widget _typingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Text("Sol is typing..."),
      ),
    );
  }

  // ── Input Area ────────────────────────────────
  Widget _inputArea() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: "Ask about treatment or consultation...",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Powered By Footer ─────────────────
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha:0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withValues(alpha:0.05)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Powered by ',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha:0.55),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      'Solwor',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha:0.82),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(width: 1),

                    SizedBox(
                      width: 10,
                      height: 10,
                      child: Image.asset(
                        'assets/images/x_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 1),

                    Text(
                      'S™',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha:0.82),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
