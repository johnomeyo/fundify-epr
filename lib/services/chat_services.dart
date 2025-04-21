// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   /// ✅ Generate a unique chatroom ID by sorting and joining the user IDs
//   String _generateChatId(String userId1, String userId2) {
//     List<String> sortedIds = [userId1, userId2]..sort();
//     return sortedIds.join("_");
//   }

//   /// ✅ Get or create a chatroom
//   Future<String> getOrCreateChatroom(String userId1, String userId2) async {
//     String chatId = _generateChatId(userId1, userId2);

//     DocumentReference chatRef = _firestore.collection('chats').doc(chatId);
//     DocumentSnapshot chatDoc = await chatRef.get();

//     if (!chatDoc.exists) {
//       await chatRef.set({
//         'users': [userId1, userId2],
//         'lastMessage': '',
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     }

//     return chatId;
//   }

// /// ✅ Send a message
// Future<void> sendMessage(
//     String senderId, String receiverId, String message) async {
//   if (message.trim().isEmpty) return;

//   String chatId = _generateChatId(senderId, receiverId);

//   // Reference to the chat document
//   DocumentReference chatDocRef = _firestore.collection('chats').doc(chatId);

//   // Check if chat document exists
//   // DocumentSnapshot chatDoc = await chatDocRef.get();

//   // Add message to subcollection
//   CollectionReference messagesRef = chatDocRef.collection('messages');
//   await messagesRef.add({
//     'senderId': senderId,
//     'text': message,
//     'timestamp': FieldValue.serverTimestamp(),
//   });

//   // Use set with merge for the chat document
//   // This creates the document if it doesn't exist or updates it if it does
//   await chatDocRef.set({
//     'users': [senderId, receiverId],
//     'lastMessage': message,
//     'timestamp': FieldValue.serverTimestamp(),
//   }, SetOptions(merge: true));
// }
//   /// ✅ Get messages from a chatroom (Real-time listener)
//   Stream<QuerySnapshot> getMessages(String userId1, String userId2) {
//     String chatId = _generateChatId(userId1, userId2);

//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Generate chat ID (sorted user IDs)
//   String _generateChatId(String userId1, String userId2) {
//     List<String> sortedIds = [userId1, userId2]..sort();
//     return sortedIds.join("_");
//   }

//   // Check if a user is blocked
//   Future<bool> isUserBlocked(String blockerId, String blockedId) async {
//     final doc = await _firestore
//         .collection('users')
//         .doc(blockerId)
//         .collection('blockedUsers')
//         .doc(blockedId)
//         .get();
//     return doc.exists;
//   }

//   // Get or create chatroom
//   Future<String> getOrCreateChatroom(String userId1, String userId2) async {
//     String chatId = _generateChatId(userId1, userId2);
//     await _firestore.collection('chats').doc(chatId).set({
//       'users': [userId1, userId2],
//       'lastMessage': '',
//       'timestamp': FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//     return chatId;
//   }

//   // Send message (with blocking check)
//   Future<void> sendMessage(
//       String senderId, String receiverId, String message) async {
//     if (message.trim().isEmpty) return;

//     // Check if sender is blocked by receiver
//     if (await isUserBlocked(receiverId, senderId)) {
//       throw Exception('Cannot send message: You are blocked by this user.');
//     }

//     String chatId = _generateChatId(senderId, receiverId);
//     await _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .add({
//       'senderId': senderId,
//       'text': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     // Update last message in chat doc
//     await _firestore.collection('chats').doc(chatId).set({
//       'lastMessage': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//   }

//   // Get messages stream
//   Stream<QuerySnapshot> getMessages(String userId1, String userId2) {
//     return _firestore
//         .collection('chats')
//         .doc(_generateChatId(userId1, userId2))
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generate chat ID (sorted user IDs)
  String _generateChatId(String userId1, String userId2) {
    List<String> sortedIds = [userId1, userId2]..sort();
    return sortedIds.join("_");
  }

  // Check if a user is blocked
  Future<bool> isUserBlocked(String blockerId, String blockedId) async {
    try {
      final doc = await _firestore
          .collection('investors')
          .doc(blockerId)
          .collection('blockedUsers')
          .doc(blockedId)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking block status: $e');
      return false;
    }
  }

  // Get or create chatroom
  Future<String> getOrCreateChatroom(String userId1, String userId2) async {
    try {
      String chatId = _generateChatId(userId1, userId2);
      
      // Check if chatroom exists first
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
      
      if (!chatDoc.exists) {
        // Initialize with all required fields if it doesn't exist
        await _firestore.collection('chats').doc(chatId).set({
          'users': [userId1, userId2],
          'lastMessage': '',
          'lastMessageSenderId': '',
          'timestamp': FieldValue.serverTimestamp(),
          'unreadCount': {
            userId1: 0,
            userId2: 0
          }
        });
      }
      
      return chatId;
    } catch (e) {
      print('Error creating/getting chatroom: $e');
      throw Exception('Failed to initialize chat: $e');
    }
  }

  // Send message (with blocking check)
  Future<void> sendMessage(
      String senderId, String receiverId, String message) async {
    if (message.trim().isEmpty) return;

    try {
      // Check if sender is blocked by receiver
      if (await isUserBlocked(receiverId, senderId)) {
        throw Exception('Cannot send message: You are blocked by this user.');
      }

      String chatId = _generateChatId(senderId, receiverId);
      
      // First ensure chatroom exists
      await getOrCreateChatroom(senderId, receiverId);
      
      // Add message to messages subcollection
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': senderId,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false
      });

      // Update last message in chat doc
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': message,
        'lastMessageSenderId': senderId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      // Increment unread count for receiver
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
      if (chatDoc.exists) {
        Map<String, dynamic> data = chatDoc.data() as Map<String, dynamic>;
        Map<String, dynamic> unreadCount = data.containsKey('unreadCount') ? 
            Map<String, dynamic>.from(data['unreadCount']) : 
            {senderId: 0, receiverId: 0};
        
        unreadCount[receiverId] = (unreadCount[receiverId] ?? 0) + 1;
        
        await _firestore.collection('chats').doc(chatId).update({
          'unreadCount': unreadCount
        });
      }
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message: $e');
    }
  }

  // Get messages stream
  Stream<QuerySnapshot> getMessages(String userId1, String userId2) {
    try {
      String chatId = _generateChatId(userId1, userId2);
      return _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } catch (e) {
      print('Error getting messages: $e');
      throw Exception('Failed to retrieve messages: $e');
    }
  }
  
  // Mark messages as read
  Future<void> markMessagesAsRead(String currentUserId, String otherUserId) async {
    try {
      String chatId = _generateChatId(currentUserId, otherUserId);
      
      // Reset unread counter for current user
      await _firestore.collection('chats').doc(chatId).update({
        'unreadCount.$currentUserId': 0
      });
      
      // Mark all messages from other user as read
      QuerySnapshot unreadMessages = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('senderId', isEqualTo: otherUserId)
          .where('isRead', isEqualTo: false)
          .get();
          
      WriteBatch batch = _firestore.batch();
      for (var doc in unreadMessages.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      
      if (unreadMessages.docs.isNotEmpty) {
        await batch.commit();
      }
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }
  
  // Get user chats stream
  Stream<QuerySnapshot> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('users', arrayContains: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}