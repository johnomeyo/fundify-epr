import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastMessage;

  const MessageTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ChatPage()),
        // );
      },
      leading: CircleAvatar(
        radius: 24, // Reduced size for better UI balance
        backgroundColor: Colors.grey[300], // Placeholder background color
        child: imageUrl.isEmpty
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              )
            : ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 48, // Ensure proper scaling
                  height: 48,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // Avoid long messages breaking UI
      ),
    );
  }
}
