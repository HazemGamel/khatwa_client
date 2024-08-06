class WatchedReelsModel {
  final String message;

  WatchedReelsModel({
    required this.message,
  });

  factory WatchedReelsModel.fromJson(Map<String, dynamic> json) {
    return WatchedReelsModel(
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
