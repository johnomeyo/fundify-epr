import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: message));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Copied to clipboard')),
            );
          },
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
                topRight:
                    isUserMessage ? Radius.zero : const Radius.circular(16),
                topLeft:
                    isUserMessage ? const Radius.circular(16) : Radius.zero,
              ),
            ),
            child: SelectableText.rich(
              _buildTextSpan(message, theme, context),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isUserMessage
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Parses the message and highlights links
  TextSpan _buildTextSpan(String text, ThemeData theme, BuildContext context) {
    final linkRegex = RegExp(
      r'(https?:\/\/[^\s]+)', // Matches URLs
      caseSensitive: false,
    );

    final matches = linkRegex.allMatches(text).toList();
    if (matches.isEmpty) {
      return TextSpan(text: text);
    }

    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in matches) {
      final String beforeLink = text.substring(lastIndex, match.start);
      final String linkText = match.group(0)!;

      if (beforeLink.isNotEmpty) {
        spans.add(TextSpan(text: beforeLink));
      }

      spans.add(
        TextSpan(
          text: linkText,
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Uri.parse(linkText)),
        ),
      );

      lastIndex = match.end;
    }

    final String afterLastMatch = text.substring(lastIndex);
    if (afterLastMatch.isNotEmpty) {
      spans.add(TextSpan(text: afterLastMatch));
    }

    return TextSpan(children: spans);
  }
}