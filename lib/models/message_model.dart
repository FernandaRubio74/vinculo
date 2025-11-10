class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String connectionId;
  final String content;
  final String status; // 'sent', 'delivered', 'read'
  final DateTime createdAt;
  final DateTime? readAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.connectionId,
    required this.content,
    required this.status,
    required this.createdAt,
    this.readAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      connectionId: json['connectionId'] as String,
      content: json['content'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt'] as String) : null,
    );
  }

  bool get isRead => status == 'read';
  
  bool isSentByMe(String currentUserId) => senderId == currentUserId;
}