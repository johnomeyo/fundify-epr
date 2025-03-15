import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;
  final Timestamp? timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUserMessage,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    //  String timeText = '';
    // final date = timestamp.toDate();
    // timeText = '${date.hour}:${date.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: screenWidth * 0.6,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.primary,
            ),
            color: isUserMessage
                ? theme.colorScheme.primary
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16).copyWith(
              topRight: isUserMessage ? Radius.zero : const Radius.circular(16),
              topLeft: isUserMessage ? const Radius.circular(16) : Radius.zero,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isUserMessage
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              ),
              // if (timeText.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.only(top: 4),
              //     child: Text(
              //       "",
              //       style: TextStyle(
              //         color: isUserMessage ? Colors.white70 : Colors.black54,
              //         fontSize: 10,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}