class ReelsModel {
  final String id;
  final String url;
  final DateTime createdAt;
  final DateTime expiresAt;

  ReelsModel({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.expiresAt,
  });

  factory ReelsModel.fromJson(Map<String, dynamic> json) {
    return ReelsModel(
      id: json['_id'] as String,
      url: json['url'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'url': url,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }
}
