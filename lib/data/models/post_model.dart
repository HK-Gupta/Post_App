class PostModel {
  final String id;
  final String type;  // 'text', 'image', 'video'
  final String content;  // Can be text, URL for image, or video URL

  PostModel({
    required this.id,
    required this.type,
    required this.content,
  });

  // Factory method to convert Firestore data to PostModel
  factory PostModel.fromFirestore(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      type: json['type'] ?? 'text',
      content: json['content'] ?? '',
    );
  }

  // Convert to Map for saving in Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'content': content,
    };
  }
}
