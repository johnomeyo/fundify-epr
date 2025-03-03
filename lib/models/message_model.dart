
/// message model to represent a message with whom messages have been exchanged
class Message {
  final String name;
  final String imageUrl;
  final String message;
  final String userID;

  Message({
    required this.name,
    required this.imageUrl,
    required this.message,
    required this.userID
  });
}
