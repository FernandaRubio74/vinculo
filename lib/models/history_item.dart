class HistoryItem {
  final String id;
  final String actionType;
  final String description;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  HistoryItem({
    required this.id,
    required this.actionType,
    required this.description,
    required this.createdAt,
    this.metadata,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'].toString(),
      actionType: json['actionType'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      metadata: json['metadata'],
    );
  }
}
