// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import './chat_page.dart'; // Import your chat page

// // Define a model for chat previews
// class ChatPreview {
//   final String chatId;
//   final String userId; // The other user's ID
//   final String name;
//   final String imageUrl;
//   final String lastMessage;
//   final Timestamp timestamp;

//   ChatPreview({
//     required this.chatId,
//     required this.userId,
//     required this.name,
//     required this.imageUrl,
//     required this.lastMessage,
//     required this.timestamp,
//   });
// }

// class MessagesPage extends StatelessWidget {
//   const MessagesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final currentUserId = FirebaseAuth.instance.currentUser?.uid;

//     if (currentUserId == null) {
//       return const Scaffold(
//         body: Center(child: Text('Please sign in to view messages')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Messages'),
//         elevation: 0,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('chats')
//             .where('users', arrayContains: currentUserId)
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No messages yet'));
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final chatDoc = snapshot.data!.docs[index];
//               final chatData = chatDoc.data() as Map<String, dynamic>;
//               final List<String> users =
//                   List<String>.from(chatData['users'] ?? []);

//               // Get the other user's ID (not the current user)
//               final otherUserId = users.firstWhere(
//                 (id) => id != currentUserId,
//                 orElse: () => 'unknown',
//               );

//               // We need to fetch the other user's details
//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance
//                     .collection('investors')
//                     .doc(otherUserId)
//                     .get(),
//                 builder: (context, userSnapshot) {
//                   if (userSnapshot.connectionState == ConnectionState.waiting) {
//                     return const ListTile(
//                       leading: CircleAvatar(),
//                       title: Text('Loading...'),
//                     );
//                   }

//                   String name = 'Uknown User';
//                   String imageUrl = '';

//                   if (userSnapshot.hasData && userSnapshot.data!.exists) {
//                     final userData =
//                         userSnapshot.data!.data() as Map<String, dynamic>?;
//                     name = userData?['name'] ??
//                         userData?['displayName'] ??
//                         'Unknown Usher';
//                     imageUrl = userData?['image'] ?? '';
//                   }

//                   return MessageTile(
//                     chatId: chatDoc.id,
//                     otherUserId: otherUserId,
//                     imageUrl:imageUrl,
//                     name: name,
//                     lastMessage: chatData['lastMessage'] ?? 'No messages yet',
//                     timestamp:
//                         chatData['timestamp'] as Timestamp? ?? Timestamp.now(),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class MessageTile extends StatelessWidget {
//   final String chatId;
//   final String otherUserId;
//   final String imageUrl;
//   final String name;
//   final String lastMessage;
//   final Timestamp timestamp;

//   const MessageTile({
//     super.key,
//     required this.chatId,
//     required this.otherUserId,
//     required this.imageUrl,
//     required this.name,
//     required this.lastMessage,
//     required this.timestamp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Format timestamp
//     String timeText = '';
//     if (timestamp.seconds > 0) {
//       final DateTime dateTime = timestamp.toDate();
//       final DateTime now = DateTime.now();
//       final difference = now.difference(dateTime);

//       if (difference.inDays > 0) {
//         timeText = '${difference.inDays}d ago';
//       } else if (difference.inHours > 0) {
//         timeText = '${difference.inHours}h ago';
//       } else if (difference.inMinutes > 0) {
//         timeText = '${difference.inMinutes}m ago';
//       } else {
//         timeText = 'Just now';
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: ListTile(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChatPage(
//                 otherUserId: otherUserId,
//                 otherUserName: name,
//               ),
//             ),
//           );
//         },
//         leading: CircleAvatar(
//           radius: 24,
//           backgroundColor: Colors.grey[300],
//           child: imageUrl.isEmpty
//               ? Text(
//                   name.isNotEmpty ? name[0].toUpperCase() : '?',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black54,
//                   ),
//                 )
//               : ClipOval(
//                   child: CachedNetworkImage(
//                     imageUrl: imageUrl,
//                     width: 48,
//                     height: 48,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) =>
//                         const CircularProgressIndicator(strokeWidth: 2),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error, color: Colors.red),
//                   ),
//                 ),
//         ),
//         title:
//             Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(
//           lastMessage,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         trailing: timeText.isNotEmpty
//             ? Text(
//                 timeText,
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 12,
//                 ),
//               )
//             : null,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fundora/services/chat_services.dart' show ChatService;
import './chat_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final ChatService _chatService = ChatService();

    if (currentUserId == null) {
      return const Scaffold(
        body: Center(child: Text('Please sign in to view messages')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _chatService.getUserChats(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No messages yet'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final chatDoc = snapshot.data!.docs[index];
              final chatData = chatDoc.data() as Map<String, dynamic>;
              final List<String> users = List<String>.from(chatData['users'] ?? []);

              // Get the other user's ID (not the current user)
              final otherUserId = users.firstWhere(
                (id) => id != currentUserId,
                orElse: () => 'unknown',
              );
              
              // Get unread count for current user
              int unreadCount = 0;
              if (chatData.containsKey('unreadCount') && 
                  (chatData['unreadCount'] as Map<String, dynamic>).containsKey(currentUserId)) {
                unreadCount = (chatData['unreadCount'] as Map<String, dynamic>)[currentUserId] ?? 0;
              }
              
              // Get last message sender (to show "You: " prefix if needed)
              bool isLastMessageFromMe = chatData['lastMessageSenderId'] == currentUserId;

              // We need to fetch the other user's details
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('investors')
                    .doc(otherUserId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      leading: CircleAvatar(),
                      title: Text('Loading...'),
                    );
                  }

                  String name = 'Unknown User';
                  String imageUrl = '';

                  if (userSnapshot.hasData && userSnapshot.data!.exists) {
                    final userData =
                        userSnapshot.data!.data() as Map<String, dynamic>?;
                    name = userData?['name'] ??
                        userData?['displayName'] ??
                        'Unknown User';
                    imageUrl = userData?['image'] ?? '';
                  }

                  return MessageTile(
                    chatId: chatDoc.id,
                    otherUserId: otherUserId,
                    imageUrl: imageUrl,
                    name: name,
                    lastMessage: chatData['lastMessage'] ?? 'No messages yet',
                    isLastMessageFromMe: isLastMessageFromMe,
                    unreadCount: unreadCount,
                    timestamp:
                        chatData['timestamp'] as Timestamp? ?? Timestamp.now(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String chatId;
  final String otherUserId;
  final String imageUrl;
  final String name;
  final String lastMessage;
  final bool isLastMessageFromMe;
  final int unreadCount;
  final Timestamp timestamp;

  const MessageTile({
    super.key,
    required this.chatId,
    required this.otherUserId,
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    this.isLastMessageFromMe = false,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Format timestamp
    String timeText = '';
    if (timestamp.seconds > 0) {
      final DateTime dateTime = timestamp.toDate();
      final DateTime now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        timeText = '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        timeText = '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        timeText = '${difference.inMinutes}m ago';
      } else {
        timeText = 'Just now';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        tileColor: unreadCount > 0 ? Colors.blue.withOpacity(0.1) : null,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                otherUserId: otherUserId,
                otherUserName: name,
              ),
            ),
          );
        },
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[300],
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
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
            ),
            if (unreadCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    unreadCount > 9 ? '9+' : '$unreadCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          name, 
          style: TextStyle(
            fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal
          )
        ),
        subtitle: Text(
          isLastMessageFromMe ? 'You: $lastMessage' : lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              timeText,
              style: TextStyle(
                color: unreadCount > 0 ? Colors.blue : Colors.grey[600],
                fontSize: 12,
                fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}