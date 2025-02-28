import 'package:flutter/material.dart';
import 'package:fundora/data.dart';
import 'package:fundora/pages/chat/chat_bubble.dart';

/// Chat Page: Displays the chat interface for a specific message
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ValueNotifier<bool> _isSendEnabled = ValueNotifier(false);
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_updateSendButton);
  }

  @override
  void dispose() {
    _messageController.removeListener(_updateSendButton);
    _messageController.dispose();
    _isSendEnabled.dispose();
    super.dispose();
  }

  void _updateSendButton() {
    _isSendEnabled.value = _messageController.text.trim().isNotEmpty;
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    _messages.add(_messageController.text.trim());
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.video_call_sharp)),
          const SizedBox(width: 10),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUserMessage = messages[index].userID == '1';
                return ChatBubble(
                  message: messages[index].message,
                  isUserMessage:
                      isUserMessage, // Assuming messages are from the user
                );
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ValueListenableBuilder<bool>(
            valueListenable: _isSendEnabled,
            builder: (context, isEnabled, child) {
              return CircleAvatar(
                radius: 25,
                backgroundColor: isEnabled ? theme.primaryColor : Colors.grey,
                child: IconButton(
                  icon: const Icon(Icons.arrow_upward, color: Colors.white),
                  onPressed: isEnabled ? _sendMessage : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}