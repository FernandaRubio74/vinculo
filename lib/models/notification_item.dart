class NotificationItem {
  final String id;
  final String message;
  final bool read;
  final DateTime createdAt;
  final String? sender;

  NotificationItem({
    required this.id,
    required this.message,
    required this.read,
    required this.createdAt,
    this.sender,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'].toString(),
      message: json['message'] ?? '',
      read: json['read'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      sender: json['sender'],
    );
  }
}
