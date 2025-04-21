// import 'dart:async' show StreamSubscription;

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
//   bool _isCurrentUserBlocked = false;
//   StreamSubscription<DocumentSnapshot>? _blockStatusSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _checkBlockStatus();
//     _listenToBlockStatus();
//   }

//   Future<void> _checkBlockStatus() async {
//     if (_currentUserId.isEmpty) return;

//     final isUserBlocked = await _chatService.isUserBlocked(
//       _currentUserId,
//       widget.otherUserId,
//     );
//     final isCurrentUserBlocked = await _chatService.isUserBlocked(
//       widget.otherUserId,
//       _currentUserId,
//     );

//     if (mounted) {
//       setState(() {
//         _isUserBlocked = isUserBlocked;
//         _isCurrentUserBlocked = isCurrentUserBlocked;
//       });
//     }
//   }

//   void _listenToBlockStatus() {
//     _blockStatusSubscription = _firestore
//         .collection('users')
//         .doc(widget.otherUserId)
//         .collection('blockedUsers')
//         .doc(_currentUserId)
//         .snapshots()
//         .listen((doc) {
//       if (mounted) {
//         setState(() => _isCurrentUserBlocked = doc.exists);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _blockStatusSubscription?.cancel();
//     super.dispose();
//   }

//   Future<void> _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;
//     setState(() => _isLoading = true);

//     try {
//       await _chatService.sendMessage(
//         _currentUserId,
//         widget.otherUserId,
//         _messageController.text,
//       );
//       _messageController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _toggleBlockUser(bool block) async {
//     final confirmed = await showDialog<bool>(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(block ? 'Block User' : 'Unblock User'),
//             content: Text(block
//                 ? 'Block ${widget.otherUserName}? They won\'t be able to message you.'
//                 : 'Unblock ${widget.otherUserName}?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 child: Text(block ? 'Block' : 'Unblock'),
//               ),
//             ],
//           ),
//         ) ??
//         false;

//     if (!confirmed) return;

//     setState(() => _isLoading = true);
//     try {
//       final blockRef = _firestore
//           .collection('users')
//           .doc(_currentUserId)
//           .collection('blockedUsers')
//           .doc(widget.otherUserId);

//       block
//           ? await blockRef.set({
//               'blockedAt': FieldValue.serverTimestamp(),
//               'reason': 'User-initiated block',
//             })
//           : await blockRef.delete();

//       if (mounted) {
//         setState(() => _isUserBlocked = block);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('User ${block ? 'blocked' : 'unblocked'}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
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
//                       title: Text(reason),
//                       value: reason,
//                       groupValue: selectedReason,
//                       onChanged: (value) {
//                         setState(() => selectedReason = value);
//                       },
//                     )),
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
//             content: Text(
//                 'Report submitted. Thank you for keeping our community safe.'),
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
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.otherUserName),
//         actions: [
//           IconButton(
//             icon: Icon(_isUserBlocked ? Icons.person_add : Icons.block),
//             onPressed: () => _toggleBlockUser(!_isUserBlocked),
//           ),
//           IconButton(
//             icon: const Icon(Icons.flag_outlined),
//             tooltip: 'Report User',
//             onPressed: _reportUser,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Blocked status banner
//           if (_isCurrentUserBlocked)
//             Container(
//               color: Colors.red[100],
//               padding: const EdgeInsets.all(8),
//               child: const Text(
//                 'You are blocked by this user',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),

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
// //               },
// //             ),
// //           ),
//               },
//             ),
//           ),

//           // Input field (hidden if blocked either way)
//           if (!_isUserBlocked && !_isCurrentUserBlocked)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: _isLoading
//                         ? const CircularProgressIndicator()
//                         : const Icon(Icons.send),
//                     onPressed: _sendMessage,
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async' show StreamSubscription;

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
    
    // Mark messages as read when opening the chat
    if (_currentUserId.isNotEmpty) {
      _chatService.markMessagesAsRead(_currentUserId, widget.otherUserId);
    }
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
        .collection('investors')
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
          .collection('investors')
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

  void _reportUser() async {
    final reportReasons = [
      'Inappropriate content',
      'Harassment or bullying',
      'Spam or scam',
      'Impersonation',
      'Other',
    ];

    String? selectedReason;
    String additionalInfo = '';

    // Show report dialog with reason selection
    final bool? shouldReport = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Report User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Why are you reporting ${widget.otherUserName}?'),
                const SizedBox(height: 16),
                ...reportReasons.map((reason) => RadioListTile<String>(
                      title: Text(reason),
                      value: reason,
                      groupValue: selectedReason,
                      onChanged: (value) {
                        setState(() => selectedReason = value);
                      },
                    )),
                const SizedBox(height: 16),
                const Text('Additional information (optional):'),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please provide details about your report...',
                  ),
                  onChanged: (value) {
                    additionalInfo = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: selectedReason == null
                  ? null
                  : () => Navigator.of(context).pop(true),
              child: const Text('REPORT'),
            ),
          ],
        ),
      ),
    );

    if (shouldReport != true || selectedReason == null) return;

    setState(() => _isLoading = true);

    try {
      // Create a unique report ID
      final reportId = _firestore.collection('reports').doc().id;

      // Save the report
      await _firestore.collection('reports').doc(reportId).set({
        'reportingUserId': _currentUserId,
        'reportedUserId': widget.otherUserId,
        'reportedUserName': widget.otherUserName,
        'reason': selectedReason,
        'additionalInfo': additionalInfo,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending', // Can be 'pending', 'reviewed', 'resolved', etc.
      });

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Report submitted. Thank you for keeping our community safe.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting report: $e')),
        );
      }
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
          IconButton(
            icon: const Icon(Icons.flag_outlined),
            tooltip: 'Report User',
            onPressed: _reportUser,
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
              width: double.infinity,
              child: const Text(
                'You are blocked by this user',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),

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
                
                // Mark messages as read when receiving new messages
                if (messages.isNotEmpty) {
                  _chatService.markMessagesAsRead(_currentUserId, widget.otherUserId);
                }

                return ListView.builder(
                  reverse: true, // Messages show newest at the bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // Since we're using reverse: true, we don't need to reverse the index
                    final messageData = messages[index].data() as Map<String, dynamic>;
                    final isMe = messageData['senderId'] == _currentUserId;
                    final timestamp = messageData['timestamp'] as Timestamp?;

                    return ChatBubble(
                      message: messageData['text'] ?? '',
                      isUserMessage: isMe,
                      timestamp: timestamp,
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
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: _isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                    onPressed: _isLoading ? null : _sendMessage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}