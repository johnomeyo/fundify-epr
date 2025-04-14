// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fundora/pages/chat/chat_bubble.dart';
// import 'package:fundora/services/chat_services.dart';

// class ChatPage extends StatefulWidget {
//   final String otherUserId;
//   final String otherUserName;

//   const ChatPage({
//     super.key,
//     required this.otherUserId,
//     required this.otherUserName,
//   });

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
//   bool _isLoading = false;
//   bool _isUserBlocked = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkIfUserIsBlocked();
//   }

//   Future<void> _checkIfUserIsBlocked() async {
//     if (_currentUserId.isEmpty) return;

//     try {
//       final doc = await _firestore
//           .collection('users')
//           .doc(_currentUserId)
//           .collection('blockedUsers')
//           .doc(widget.otherUserId)
//           .get();

//       if (mounted) {
//         setState(() {
//           _isUserBlocked = doc.exists;
//         });
//       }
//     } catch (e) {
//       // Handle error silently
//       print('Error checking blocked status: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   void _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;

//     final message = _messageController.text;
//     _messageController.clear();

//     setState(() => _isLoading = true);

//     try {
//       await _chatService.sendMessage(
//         _currentUserId,
//         widget.otherUserId,
//         message,
//       );
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error sending message: $e')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   void _blockUser() async {
//     // Show confirmation dialog
//     final bool confirm = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Block User'),
//         content: Text('Are you sure you want to block ${widget.otherUserName}? You won\'t receive messages from them anymore.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('CANCEL'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('BLOCK'),
//           ),
//         ],
//       ),
//     ) ?? false;

//     if (!confirm) return;

//     setState(() => _isLoading = true);

//     try {
//       // Add user to blocked list
//       await _firestore
//           .collection('users')
//           .doc(_currentUserId)
//           .collection('blockedUsers')
//           .doc(widget.otherUserId)
//           .set({
//             'blockedAt': FieldValue.serverTimestamp(),
//             'userName': widget.otherUserName,
//           });

//       if (mounted) {
//         setState(() {
//           _isUserBlocked = true;
//           _isLoading = false;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('${widget.otherUserName} has been blocked')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error blocking user: $e')),
//         );
//       }
//     }
//   }

//   void _unblockUser() async {
//     // Show confirmation dialog
//     final bool confirm = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Unblock User'),
//         content: Text('Do you want to unblock ${widget.otherUserName}?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('CANCEL'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('UNBLOCK'),
//           ),
//         ],
//       ),
//     ) ?? false;

//     if (!confirm) return;

//     setState(() => _isLoading = true);

//     try {
//       // Remove user from blocked list
//       await _firestore
//           .collection('users')
//           .doc(_currentUserId)
//           .collection('blockedUsers')
//           .doc(widget.otherUserId)
//           .delete();

//       if (mounted) {
//         setState(() {
//           _isUserBlocked = false;
//           _isLoading = false;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('${widget.otherUserName} has been unblocked')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error unblocking user: $e')),
//         );
//       }
//     }
//   }

//   void _reportUser() async {
//     final reportReasons = [
//       'Inappropriate content',
//       'Harassment or bullying',
//       'Spam or scam',
//       'Impersonation',
//       'Other',
//     ];

//     String? selectedReason;
//     String additionalInfo = '';

//     // Show report dialog with reason selection
//     final bool? shouldReport = await showDialog<bool>(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           title: const Text('Report User'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Why are you reporting ${widget.otherUserName}?'),
//                 const SizedBox(height: 16),
//                 ...reportReasons.map((reason) => RadioListTile<String>(
//                   title: Text(reason),
//                   value: reason,
//                   groupValue: selectedReason,
//                   onChanged: (value) {
//                     setState(() => selectedReason = value);
//                   },
//                 )),
//                 const SizedBox(height: 16),
//                 const Text('Additional information (optional):'),
//                 const SizedBox(height: 8),
//                 TextField(
//                   maxLines: 3,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Please provide details about your report...',
//                   ),
//                   onChanged: (value) {
//                     additionalInfo = value;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('CANCEL'),
//             ),
//             TextButton(
//               onPressed: selectedReason == null
//                   ? null
//                   : () => Navigator.of(context).pop(true),
//               child: const Text('REPORT'),
//             ),
//           ],
//         ),
//       ),
//     );

//     if (shouldReport != true || selectedReason == null) return;

//     setState(() => _isLoading = true);

//     try {
//       // Create a unique report ID
//       final reportId = _firestore.collection('reports').doc().id;

//       // Save the report
//       await _firestore.collection('reports').doc(reportId).set({
//         'reportingUserId': _currentUserId,
//         'reportedUserId': widget.otherUserId,
//         'reportedUserName': widget.otherUserName,
//         'reason': selectedReason,
//         'additionalInfo': additionalInfo,
//         'timestamp': FieldValue.serverTimestamp(),
//         'status': 'pending', // Can be 'pending', 'reviewed', 'resolved', etc.
//       });

//       if (mounted) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Report submitted. Thank you for keeping our community safe.'),
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error submitting report: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_currentUserId.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(title: Text(widget.otherUserName)),
//         body: const Center(child: Text('Please sign in to chat')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.otherUserName),
//         actions: [
//           // Report button
//           IconButton(
//             icon: const Icon(Icons.flag_outlined),
//             tooltip: 'Report User',
//             onPressed: _reportUser,
//           ),
//           // Block/Unblock button
//           IconButton(
//             icon: Icon(_isUserBlocked ? Icons.person_add : Icons.block),
//             tooltip: _isUserBlocked ? 'Unblock User' : 'Block User',
//             onPressed: _isUserBlocked ? _unblockUser : _blockUser,
//           ),
//           // More options button (optional)
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               if (value == 'block') {
//                 _blockUser();
//               } else if (value == 'unblock') {
//                 _unblockUser();
//               } else if (value == 'report') {
//                 _reportUser();
//               }
//             },
//             itemBuilder: (context) => [
//               if (_isUserBlocked)
//                 const PopupMenuItem(
//                   value: 'unblock',
//                   child: Row(
//                     children: [
//                       Icon(Icons.person_add),
//                       SizedBox(width: 8),
//                       Text('Unblock user'),
//                     ],
//                   ),
//                 )
//               else
//                 const PopupMenuItem(
//                   value: 'block',
//                   child: Row(
//                     children: [
//                       Icon(Icons.block),
//                       SizedBox(width: 8),
//                       Text('Block user'),
//                     ],
//                   ),
//                 ),
//               const PopupMenuItem(
//                 value: 'report',
//                 child: Row(
//                   children: [
//                     Icon(Icons.flag_outlined),
//                     SizedBox(width: 8),
//                     Text('Report user'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: _isUserBlocked
//       ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.block, size: 64, color: Colors.grey),
//               const SizedBox(height: 16),
//               Text('You have blocked ${widget.otherUserName}',
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 8),
//               ElevatedButton.icon(
//                 onPressed: _unblockUser,
//                 icon: const Icon(Icons.person_add),
//                 label: const Text('Unblock User'),
//               ),
//             ],
//           ),
//         )
//       : Column(
//         children: [
//           // Messages list
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream:
//                   _chatService.getMessages(_currentUserId, widget.otherUserId),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting &&
//                     !snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(
//                       child: Text('No messages yet. Say hello!'));
//                 }

//                 final messages = snapshot.data!.docs;

//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     // Reverse the index since we want newest at the bottom
//                     // and our messages are ordered with oldest first
//                     final messageData = messages[messages.length - 1 - index]
//                         .data() as Map<String, dynamic>;
//                     final isMe = messageData['senderId'] == _currentUserId;

//                     return ChatBubble(
//                       message: messageData['text'] ?? '',
//                       isUserMessage: isMe,
//                       // timestamp: messageData['timestamp'] as Timestamp,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),

//           // Input field
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 3,
//                     offset: const Offset(0, -1),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // Message input
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message',
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(
//                             horizontal: 8.0, vertical: 12.0),
//                       ),
//                       maxLines: null, // Allow multiple lines
//                       textCapitalization: TextCapitalization.sentences,
//                       onChanged: (text) {
//                         // Force rebuild when text changes to update button color
//                         setState(() {});
//                       },
//                     ),
//                   ),

//                   // Send button
//                   IconButton(
//                     icon: _isLoading
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                         : CircleAvatar(
//                             backgroundColor:
//                                 _messageController.text.trim().isEmpty
//                                     ? Theme.of(context)
//                                         .colorScheme
//                                         .surface
//                                         .withOpacity(0.3)
//                                     : Theme.of(context)
//                                         .colorScheme
//                                         .primary, // Primary color when has text
//                             child: Icon(
//                               Icons.arrow_upward,
//                               color: _messageController.text.trim().isEmpty
//                                   ? Colors.grey[600] // Grey icon when empty
//                                   : Colors.white, // White icon when has text
//                             )),
//                     onPressed:
//                         (_isLoading || _messageController.text.trim().isEmpty)
//                             ? null // Disable button when loading or empty
//                             : _sendMessage,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  bool _isLoading = false;
  bool _isUserBlocked = false;
  bool _isCurrentUserBlocked = false;
  StreamSubscription<DocumentSnapshot>? _blockStatusSubscription;

  @override
  void initState() {
    super.initState();
    _checkBlockStatus();
    _listenToBlockStatus();
  }

  Future<void> _checkBlockStatus() async {
    if (_currentUserId.isEmpty) return;

    final isUserBlocked = await _chatService.isUserBlocked(
      _currentUserId,
      widget.otherUserId,
    );
    final isCurrentUserBlocked = await _chatService.isUserBlocked(
      widget.otherUserId,
      _currentUserId,
    );

    if (mounted) {
      setState(() {
        _isUserBlocked = isUserBlocked;
        _isCurrentUserBlocked = isCurrentUserBlocked;
      });
    }
  }

  void _listenToBlockStatus() {
    _blockStatusSubscription = _firestore
        .collection('users')
        .doc(widget.otherUserId)
        .collection('blockedUsers')
        .doc(_currentUserId)
        .snapshots()
        .listen((doc) {
      if (mounted) {
        setState(() => _isCurrentUserBlocked = doc.exists);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _blockStatusSubscription?.cancel();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);

    try {
      await _chatService.sendMessage(
        _currentUserId,
        widget.otherUserId,
        _messageController.text,
      );
      _messageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleBlockUser(bool block) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(block ? 'Block User' : 'Unblock User'),
            content: Text(block
                ? 'Block ${widget.otherUserName}? They won\'t be able to message you.'
                : 'Unblock ${widget.otherUserName}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(block ? 'Block' : 'Unblock'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) return;

    setState(() => _isLoading = true);
    try {
      final blockRef = _firestore
          .collection('users')
          .doc(_currentUserId)
          .collection('blockedUsers')
          .doc(widget.otherUserId);

      block
          ? await blockRef.set({
              'blockedAt': FieldValue.serverTimestamp(),
              'reason': 'User-initiated block',
            })
          : await blockRef.delete();

      if (mounted) {
        setState(() => _isUserBlocked = block);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User ${block ? 'blocked' : 'unblocked'}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUserName),
        actions: [
          IconButton(
            icon: Icon(_isUserBlocked ? Icons.person_add : Icons.block),
            onPressed: () => _toggleBlockUser(!_isUserBlocked),
          ),
        ],
      ),
      body: Column(
        children: [
          // Blocked status banner
          if (_isCurrentUserBlocked)
            Container(
              color: Colors.red[100],
              padding: const EdgeInsets.all(8),
              child: const Text(
                'You are blocked by this user',
                style: TextStyle(color: Colors.red),
              ),
            ),

          // Messages list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _chatService.getMessages(_currentUserId, widget.otherUserId),
              builder: (context, snapshot) {
                // ... (keep your existing message list builder) ...
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
                    // Reverse the index since we want newest at the bottom
                    // and our messages are ordered with oldest first
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

          // Input field (hidden if blocked either way)
          if (!_isUserBlocked && !_isCurrentUserBlocked)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: _isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
