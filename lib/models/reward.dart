class Reward {
  final String id;
  final String name;
  final String description;
  final int pointsRequired;
  final String? imageUrl;
  final bool isActive;

  Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsRequired,
    this.imageUrl,
    required this.isActive,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pointsRequired: json['pointsRequired'] ?? 0,
      imageUrl: json['imageUrl'],
      isActive: json['isActive'] ?? false,
    );
  }
}
