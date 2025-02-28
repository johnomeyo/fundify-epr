// Messages Page
import 'package:flutter/material.dart';
import 'package:fundora/data.dart';
import 'package:fundora/pages/chat/message_tile.dart';

/// Messages Page: Displays a list of users with whom messages have been exchanged
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        // centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return MessageTile(
            imageUrl: message.imageUrl,
            name: message.name,
            lastMessage: message.message,
          );
        },
      ),
    );
  }
}
