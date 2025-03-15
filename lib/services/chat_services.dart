import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Generate a unique chatroom ID by sorting and joining the user IDs
  String _generateChatId(String userId1, String userId2) {
    List<String> sortedIds = [userId1, userId2]..sort();
    return sortedIds.join("_");
  }

  /// ✅ Get or create a chatroom
  Future<String> getOrCreateChatroom(String userId1, String userId2) async {
    String chatId = _generateChatId(userId1, userId2);

    DocumentReference chatRef = _firestore.collection('chats').doc(chatId);
    DocumentSnapshot chatDoc = await chatRef.get();

    if (!chatDoc.exists) {
      await chatRef.set({
        'users': [userId1, userId2],
        'lastMessage': '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    return chatId;
  }

/// ✅ Send a message
Future<void> sendMessage(
    String senderId, String receiverId, String message) async {
  if (message.trim().isEmpty) return;

  String chatId = _generateChatId(senderId, receiverId);

  // Reference to the chat document
  DocumentReference chatDocRef = _firestore.collection('chats').doc(chatId);
  
  // Check if chat document exists
  // DocumentSnapshot chatDoc = await chatDocRef.get();
  
  // Add message to subcollection
  CollectionReference messagesRef = chatDocRef.collection('messages');
  await messagesRef.add({
    'senderId': senderId,
    'text': message,
    'timestamp': FieldValue.serverTimestamp(),
  });

  // Use set with merge for the chat document
  // This creates the document if it doesn't exist or updates it if it does
  await chatDocRef.set({
    'users': [senderId, receiverId],
    'lastMessage': message,
    'timestamp': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}
  /// ✅ Get messages from a chatroom (Real-time listener)
  Stream<QuerySnapshot> getMessages(String userId1, String userId2) {
    String chatId = _generateChatId(userId1, userId2);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}