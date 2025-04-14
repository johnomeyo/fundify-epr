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
    final doc = await _firestore
        .collection('users')
        .doc(blockerId)
        .collection('blockedUsers')
        .doc(blockedId)
        .get();
    return doc.exists;
  }

  // Get or create chatroom
  Future<String> getOrCreateChatroom(String userId1, String userId2) async {
    String chatId = _generateChatId(userId1, userId2);
    await _firestore.collection('chats').doc(chatId).set({
      'users': [userId1, userId2],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return chatId;
  }

  // Send message (with blocking check)
  Future<void> sendMessage(
      String senderId, String receiverId, String message) async {
    if (message.trim().isEmpty) return;

    // Check if sender is blocked by receiver
    if (await isUserBlocked(receiverId, senderId)) {
      throw Exception('Cannot send message: You are blocked by this user.');
    }

    String chatId = _generateChatId(senderId, receiverId);
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update last message in chat doc
    await _firestore.collection('chats').doc(chatId).set({
      'lastMessage': message,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Get messages stream
  Stream<QuerySnapshot> getMessages(String userId1, String userId2) {
    return _firestore
        .collection('chats')
        .doc(_generateChatId(userId1, userId2))
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
