import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fundora/pages/chat/chat_bubble.dart';
import 'package:fundora/services/chat_services.dart';


class ChatPage extends StatefulWidget {
  final String otherUserId;
  final String otherUserName;

  const ChatPage({
    super.key,
    required this.otherUserId,
    required this.otherUserName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final String _currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  bool _isLoading = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final message = _messageController.text;
    _messageController.clear();

    setState(() => _isLoading = true);

    try {
      await _chatService.sendMessage(
        _currentUserId,
        widget.otherUserId,
        message,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending message: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUserId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.otherUserName)),
        body: const Center(child: Text('Please sign in to chat')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.otherUserName)),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _chatService.getMessages(_currentUserId, widget.otherUserId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text('No messages yet. Say hello!'));
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // Display messages in reverse order (newest at bottom)
                    final messageData = messages[messages.length - 1 - index]
                        .data() as Map<String, dynamic>;
                    final isMe = messageData['senderId'] == _currentUserId;

                    return ChatBubble(
                      message: messageData['text'] ?? '',
                      isUserMessage: isMe,
                      // timestamp: messageData['timestamp'] as Timestamp,
                    );
                  },
                );
              },
            ),
          ),

          // Input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withValues(alpha: 0.2), // Fix for withValues -> withOpacity
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Message input
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12.0),
                      ),
                      maxLines: null, // Allow multiple lines
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (text) {
                        // Force rebuild when text changes to update button color
                        setState(() {});
                      },
                    ),
                  ),

                  // Send button
                  IconButton(
                    icon: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : CircleAvatar(
                            backgroundColor: _messageController.text
                                    .trim()
                                    .isEmpty
                                ? Colors.grey[300] // Grey when empty
                                : Theme.of(context)
                                    .primaryColor, // Primary color when has text
                            child: Icon(
                              Icons.arrow_upward,
                              color: _messageController.text.trim().isEmpty
                                  ? Colors.grey[600] // Grey icon when empty
                                  : Colors.white, // White icon when has text
                            )),
                    onPressed:
                        (_isLoading || _messageController.text.trim().isEmpty)
                            ? null // Disable button when loading or empty
                            : _sendMessage,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}